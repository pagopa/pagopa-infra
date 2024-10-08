parameters{
	daysToRecover as integer (7)
}
source(output(
		infoBlurredNumber as string,
		paymentToken as string,
		debtorEntityUniqueIdentifier as string,
		iuv as string,
		pspBusinessName as string,
		idPA as string,
		userFiscalCode as string,
		paymentMethod as string,
		iur as string,
		infoHolder as string,
		totalNotice as string,
		amount as string,
		infoBrand as string,
		modelType as short,
		paymentRemittanceInformation as string,
		id as string,
		payerEntityUniqueIdentifier as string,
		userSurname as string,
		companyName as string,
		payerFullName as string,
		debtorFullName as string,
		transactionRrn as string,
		transactionCreationDate as string,
		transferList as (idTransfer as boolean, fiscalCodePA as string, companyName as string, amount as string, transferCategory as string, remittanceInformation as string)[],
		paymentDateTime as string,
		psp as string,
		numAut as string,
		transactionId as string,
		userName as string,
		serviceIdentifier as string,
		noticeNumber as string,
		fee as string
	),
	allowSchemaDrift: true,
	validateSchema: true,
	query: (concat("SELECT c.id as id,c.paymentInfo.totalNotice != null ? c.paymentInfo.totalNotice : 1 as totalNotice,c.paymentInfo.paymentDateTime != null ? c.paymentInfo.paymentDateTime : null as paymentDateTime,c.transactionDetails.transaction.creationDate != null ? c.transactionDetails.transaction.creationDate : null as transactionCreationDate,c.transactionDetails.transaction.transactionId != null ? c.transactionDetails.transaction.transactionId : null as transactionId,c.debtor.entityUniqueIdentifierValue != null ? c.debtor.entityUniqueIdentifierValue : null as debtorEntityUniqueIdentifier,c.payer.entityUniqueIdentifierValue != null ? c.payer.entityUniqueIdentifierValue : null as payerEntityUniqueIdentifier,c.transactionDetails.user.fiscalCode != null ? c.transactionDetails.user.fiscalCode : null as userFiscalCode, c.transactionDetails.transaction.rrn != null ? c.transactionDetails.transaction.rrn : null as transactionRrn, c.paymentInfo.paymentToken != null ? c.paymentInfo.paymentToken : null as paymentToken,c.paymentInfo.IUR != null ? c.paymentInfo.IUR : null as iur, c.transactionDetails.transaction.numAut != null ? c.transactionDetails.transaction.numAut : null as numAut, c.transactionDetails.transaction.fee != null ? c.transactionDetails.transaction.fee : null as fee, c.transactionDetails.user.name != null ? c.transactionDetails.user.name : null as userName,c.transactionDetails.user.surname != null ? c.transactionDetails.user.surname : null as userSurname,c.payer.fullName != null ? c.payer.fullName : null as payerFullName, c.paymentInfo.paymentMethod != null ? c.paymentInfo.paymentMethod : null as paymentMethod, c.transactionDetails.wallet.info.brand != null ? c.transactionDetails.wallet.info.brand : null as infoBrand,c.transactionDetails.wallet.info.blurredNumber != null ? c.transactionDetails.wallet.info.blurredNumber : null as infoBlurredNumber,c.transactionDetails.wallet.info.holder != null ? c.transactionDetails.wallet.info.holder : null as infoHolder, c.transactionDetails.transaction.psp.businessName != null ? c.transactionDetails.transaction.psp.businessName : null as pspBusinessName,c.psp.psp != null ? c.psp.psp : null as psp, c.properties.serviceIdentifier != null ? c.properties.serviceIdentifier : null as serviceIdentifier, c.paymentInfo.remittanceInformation != null ? c.paymentInfo.remittanceInformation : null as paymentRemittanceInformation, c.paymentInfo.amount != null ? c.paymentInfo.amount : null as amount, ARRAY_LENGTH(c.transferList) > 0 ? c.transferList : [] as transferList, c.creditor.companyName != null ? c.creditor.companyName : null as companyName,c.creditor.idPA != null ? c.creditor.idPA : null as idPA,c.debtor.fullName != null ? c.debtor.fullName : null as debtorFullName,c.debtorPosition.modelType != null ? c.debtorPosition.modelType : null as modelType,c.debtorPosition.noticeNumber != null ? c.debtorPosition.noticeNumber : null as noticeNumber,c.debtorPosition.iuv != null ? c.debtorPosition.iuv : null as iuv FROM c WHERE c.eventStatus = 'DONE' AND (c.timestamp <= DateTimeToTimestamp(DateTimeAdd('dd', -"+toString($daysToRecover)+", GetCurrentDateTime())))")),
	format: 'documentQuery',
	systemColumns: false) ~> BizEventsSourceData
BizEventsSourceData call(mapColumn(
		pii = debtorEntityUniqueIdentifier
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	output(
		headers as [string,string],
		bodyDebtor as (token as string),
		status as string
	),
	allowSchemaDrift: true,
	format: 'rest',
	store: 'restservice',
	timeout: 30,
	requestInterval: 0,
	httpMethod: 'PUT',
	entity: '/tokenizer/v1/tokens',
	headerColumnName: 'headers',
	bodyColumnName: 'bodyDebtor',
	statusColumnName: 'status',
	addResponseCode: true,
	requestFormat: ['type' -> 'json'],
	responseFormat: ['type' -> 'json', 'documentForm' -> 'documentPerLine'],
	httpCompressionType: 'gzip') ~> externalCallDebtorTokenizer
derivedColumnDebtorTaxCode call(mapColumn(
		pii = {_viewPayerTaxCode}
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	output(
		headers as [string,string],
		bodyPayer as (token as string),
		status as string
	),
	allowSchemaDrift: true,
	format: 'rest',
	store: 'restservice',
	timeout: 30,
	requestInterval: 0,
	httpMethod: 'PUT',
	entity: '/tokenizer/v1/tokens',
	headerColumnName: 'headers',
	bodyColumnName: 'bodyPayer',
	statusColumnName: 'status',
	addResponseCode: true,
	requestFormat: ['type' -> 'json'],
	responseFormat: ['type' -> 'json', 'documentForm' -> 'documentPerLine'],
	httpCompressionType: 'gzip') ~> externalCallPayerTokenizer
derivedColumnPayerTaxCode derive({_viewTransactionId} = case(toString(totalNotice) != "1", toString(transactionId), id),
		{_ viewTransactionDate} = case(isNull(transactionCreationDate),paymentDateTime,toString(transactionCreationDate)),
		{_viewDebtorTaxCode} = debtorEntityUniqueIdentifier,
		{_viewHidden} = toBoolean("false"),
		{_viewIsCart} = toInteger(toString(totalNotice)) > 1,
		{_viewRrn} = case(!isNull(transactionRrn),transactionRrn,case(!isNull(paymentToken),paymentToken,iur)),
		{_viewAuthCode} = numAut,
		{_viewFee} = fee,
		{_viewPayerName} = case(!isNull(userName) && !isNull(userSurname), userName + " " + userSurname, payerFullName),
		{_viewPaymentMethod} = iif(contains(["BBT", "BP", "AD", "CP", "PO", "OBEP", "JIF", "MYBK", "PPAL", "UNKNOWN"], #item==paymentMethod), paymentMethod,'UNKNOWN'),
		{_viewInfoBrand} = infoBrand,
		{_viewInfoBlurredNumber} = infoBlurredNumber,
		{_viewInfoHolder} = infoHolder,
		{_viewPspName} = case(!isNull(pspBusinessName),pspBusinessName,psp),
		{_viewOrigin} = iif(contains(["INTERNAL", "PM", "NDP001PROD" , "NDP002PROD", "NDP003PROD", "UNKNOWN"], #item==serviceIdentifier), serviceIdentifier,'UNKNOWN'),
		{_viewTotalNotice} = totalNotice,
		{_viewEventId} = id,
		{_viewAmount} = amount,
		viewPayee = @(taxCode=idPA,
		name=companyName),
		{_viewRefNumberValue} = case(!isNull(modelType),case(modelType == 1, iuv, noticeNumber)),
		{_viewRefNumberType} = case(!isNull(modelType),case(modelType == 1, "IUV", "codiceAvviso")),
		{_viewTransferList} = transferList) ~> derivedViewColumns
derivedViewColumns split((!isNull({_viewDebtorTaxCode}) && !isNull({_viewPayerTaxCode}) && {_viewPayerTaxCode}=={_viewDebtorTaxCode}),
	(!isNull({_viewDebtorTaxCode}) && (isNull({_viewPayerTaxCode}) || {_viewPayerTaxCode}!={_viewDebtorTaxCode})),
	(!isNull({_viewPayerTaxCode}) && (isNull({_viewDebtorTaxCode}) || {_viewPayerTaxCode}!={_viewDebtorTaxCode})),
	disjoint: true) ~> splitSameDebtorAndPayer@(sameDebtorAndPayerStream, DebtorStream, PayerStream)
splitSameDebtorAndPayer@sameDebtorAndPayerStream derive({_viewUserIsPayer} = toBoolean("true"),
		{_viewId} = toString(id)+"-p") ~> derivedSameDebtorAndPayerView
splitSameDebtorAndPayer@DebtorStream derive({_viewUserIsPayer} = toBoolean("false"),
		{_viewId} = toString(id)+"-d") ~> derivedDebtorView
derivedViewColumns derive(viewPayerObj = @(taxCode={viewTokenizedPayerTaxCode},
		name={_viewPayerName}),
		viewWalletInfoObj = @(brand={_viewInfoBrand},
		blurredNumber={_viewInfoBlurredNumber},
		accountHolder={_viewInfoHolder})) ~> derivedGeneralViewObject
splitSameDebtorAndPayer@PayerStream derive({_viewUserIsPayer} = toBoolean("true"),
		{_viewId} = toString(id)+"-p") ~> derivedPayerView
derivedViewColumns derive(transferListSortedByAmount = sort(transferList, iif(#item1.amount >= #item2.amount, -1, 1))) ~> derivedSortTransferList
derivedSortTransferList derive(transferListRemittanceInformation = iif(instr(transferListSortedByAmount[1].remittanceInformation, '/TXT/')==0, transferListSortedByAmount[1].remittanceInformation, regexExtract(transferListSortedByAmount[1].remittanceInformation, '/TXT/(.*?)(/|$)'))) ~> derivedTransferListRemittanceInformation
derivedTransferListRemittanceInformation derive({_viewSubject} = iif(contains(["pagamento multibeneficiario"], #item==paymentRemittanceInformation),transferListRemittanceInformation,paymentRemittanceInformation),
		viewDebtor = @(taxCode=viewTokenizedDebtorTaxCode,
		name=debtorFullName)) ~> derivedCartViewSubjectAndDebtor
externalCallDebtorTokenizer derive(viewTokenizedDebtorTaxCode = bodyDebtor.token,
		{_viewPayerTaxCode} = case(!isNull(userFiscalCode),userFiscalCode,payerEntityUniqueIdentifier)) ~> derivedColumnDebtorTaxCode
externalCallPayerTokenizer derive(viewTokenizedPayerTaxCode = bodyPayer.token) ~> derivedColumnPayerTaxCode
derivedDebtorView sink(allowSchemaDrift: true,
	validateSchema: false,
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/taxCode'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	mapColumn(
		id = {_viewId},
		transactionId = {_viewTransactionId},
		taxCode = viewTokenizedDebtorTaxCode,
		transactionDate = {_ viewTransactionDate},
		hidden = {_viewHidden},
		isPayer = {_viewUserIsPayer}
	)) ~> ViewDebtorUserTarget
derivedPayerView sink(allowSchemaDrift: true,
	validateSchema: false,
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/taxCode'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	mapColumn(
		id = {_viewId},
		transactionId = {_viewTransactionId},
		taxCode = viewTokenizedPayerTaxCode,
		transactionDate = {_ viewTransactionDate},
		hidden = {_viewHidden},
		isPayer = {_viewUserIsPayer}
	)) ~> ViewPayerUserTarget
derivedGeneralViewObject sink(allowSchemaDrift: true,
	validateSchema: false,
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/transactionId'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	mapColumn(
		id,
		transactionId = {_viewTransactionId},
		transactionDate = {_ viewTransactionDate},
		isCart = {_viewIsCart},
		{rrn } = {_viewRrn},
		authCode = {_viewAuthCode},
		fee = {_viewFee},
		paymentMethod = {_viewPaymentMethod},
		pspName = {_viewPspName},
		origin = {_viewOrigin},
		totalNotice = {_viewTotalNotice},
		payer = viewPayerObj,
		walletInfo = viewWalletInfoObj
	)) ~> ViewGeneralTarget
derivedCartViewSubjectAndDebtor sink(allowSchemaDrift: true,
	validateSchema: false,
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/transactionId'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	mapColumn(
		id,
		transactionId = {_viewTransactionId},
		eventId = {_viewEventId},
		subject = {_viewSubject},
		amount = {_viewAmount},
		payee = viewPayee,
		debtor = viewDebtor,
		refNumberValue = {_viewRefNumberValue},
		refNumberType = {_viewRefNumberType}
	)) ~> ViewCartTarget
derivedSameDebtorAndPayerView sink(allowSchemaDrift: true,
	validateSchema: false,
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/taxCode'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	mapColumn(
		id = {_viewId},
		transactionId = {_viewTransactionId},
		taxCode = viewTokenizedPayerTaxCode,
		transactionDate = {_ viewTransactionDate},
		hidden = {_viewHidden},
		{isPayer } = {_viewUserIsPayer}
	)) ~> ViewUserTarget