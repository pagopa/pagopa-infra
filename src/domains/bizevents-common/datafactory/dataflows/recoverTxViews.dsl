parameters{
	daysToKeep as integer (90)
}
source(output(
		paymentToken as string,
		debtorEntityUniqueIdentifier as string,
		iuv as long,
		pspBusinessName as string,
		idPA as long,
		userFiscalCode as string,
		paymentMethod as string,
		iur as string,
		transactionRnn as string,
		holder as string,
		brand as string,
		eventId as string,
		totalNotice as boolean,
		amount as double,
		modelType as short,
		paymentRemittanceInformation as string,
		payerEntityUniqueIdentifier as string,
		userSurname as string,
		authCode as string,
		companyName as string,
		payerFullName as string,
		debtorFullName as string,
		transactionCreationDate as string,
		paymentDateTime as string,
		psp as string,
		blurredNumber as string,
		transactionId as string,
		userName as string,
		serviceIdentifier as string,
		noticeNumber as long,
		fee as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	query: (concat("select c.id as eventId, c.transactionDetails.transaction.transactionId != null ? c.transactionDetails.transaction.transactionId : null as transactionId,c.debtor.entityUniqueIdentifierValue != null ? c.debtor.entityUniqueIdentifierValue : null as debtorEntityUniqueIdentifier,c.payer.entityUniqueIdentifierValue != null ? c.payer.entityUniqueIdentifierValue : null as payerEntityUniqueIdentifier,c.paymentInfo.totalNotice != null ? c.paymentInfo.totalNotice : 1 as totalNotice,c.transactionDetails.transaction.creationDate != null ? c.transactionDetails.transaction.creationDate : null as transactionCreationDate,c.paymentInfo.paymentDateTime != null ? c.paymentInfo.paymentDateTime : null as paymentDateTime,c.transactionDetails.transaction.rrn != null ? c.transactionDetails.transaction.rrn : null as transactionRnn,c.paymentInfo.paymentToken != null ? c.paymentInfo.paymentToken : null as paymentToken,c.paymentInfo.IUR != null ? c.paymentInfo.IUR : null as iur,c.transactionDetails.transaction.numAut != null ? c.transactionDetails.transaction.numAut : null as authCode,c.transactionDetails.transaction.fee != null ? c.transactionDetails.transaction.fee : null as fee,c.transactionDetails.user.name != null ? c.transactionDetails.user.name : null as userName,c.transactionDetails.user.surname != null ? c.transactionDetails.user.surname : null as userSurname,c.payer.fullName != null ? c.payer.fullName : null as payerFullName,c.transactionDetails.user.fiscalCode != null ? c.transactionDetails.user.fiscalCode : null as userFiscalCode,c.paymentInfo.paymentMethod != null ? c.paymentInfo.paymentMethod : null as paymentMethod,c.transactionDetails.wallet.info.brand != null ? c.transactionDetails.wallet.info.brand : null as brand,c.transactionDetails.wallet.info.blurredNumber != null ? c.transactionDetails.wallet.info.blurredNumber : null as blurredNumber,c.transactionDetails.wallet.info.holder != null ? c.transactionDetails.wallet.info.holder : null as holder,c.transactionDetails.transaction.psp.businessName != null ? c.transactionDetails.transaction.psp.businessName : null as pspBusinessName,c.psp.psp != null ? c.psp.psp : null as psp,c.paymentInfo.remittanceInformation != null ? c.paymentInfo.remittanceInformation : null as paymentRemittanceInformation,c.creditor.companyName != null ? c.creditor.companyName : null as companyName,c.creditor.idPA != null ? c.creditor.idPA : null as idPA,c.debtor.fullName != null ? c.debtor.fullName : null as debtorFullName,c.debtorPosition.modelType != null ? c.debtorPosition.modelType : null as modelType,c.debtorPosition.noticeNumber != null ? c.debtorPosition.noticeNumber : null as noticeNumber,c.debtorPosition.iuv != null ? c.debtorPosition.iuv : null as iuv,c.paymentInfo.amount != null ? c.paymentInfo.amount : null as amount,c.properties.serviceIdentifier != null ? c.properties.serviceIdentifier : null as serviceIdentifierfrom c where c.eventStatus = 'DONE' AND (c.timestamp <= DateTimeToTimestamp(DateTimeAdd('dd', -",toString($daysToKeep),", GetCurrentDateTime())))")),
	format: 'documentQuery',
	systemColumns: false) ~> bizCosmosRead
source(output(
		obj_id as decimal(0,0),
		ident_dominio as string,
		iuv as string,
		ccp as string,
		id_sessione as string,
		inserted_timestamp as timestamp,
		updated_timestamp as timestamp
	),
	allowSchemaDrift: true,
	validateSchema: false,
	isolationLevel: 'READ_UNCOMMITTED',
	format: 'table') ~> pmPostgresRead
uniteFlows derive({_viewTransactionId} = case(toString(totalNotice) != "1", toString(transactionId), eventId),
		{_ viewTransactionDate} = case(isNull(transactionCreationDate),paymentDateTime,transactionCreationDate),
		{_viewRefType} = case(!isNull(modelType),case(modelType == 1, "IUV", "codiceAvviso")),
		{_viewRefValue} = case(!isNull(modelType),case(modelType == 1, iuv, noticeNumber)),
		{_viewRnn} = case(!isNull(transactionRnn),transactionRnn,case(!isNull(paymentToken),paymentToken,iur)),
		{_viewPayerName} = case(!isNull(userName) && !isNull(userSurname), userName + " " + userSurname, payerFullName),
		{_viewPayerTaxCode} = case(!isNull(userFiscalCode),userFiscalCode,payerEntityUniqueIdentifier),
		{_viewWalletInfo} = @(brand=brand,
		blurredNumber=blurredNumber,
		accountHolder=holder),
		{_viewPsp} = case(!isNull(pspBusinessName),pspBusinessName,psp),
		hidden = toBoolean("false"),
		isCart = toString(totalNotice) != "1",
		{_viewPayee} = @(taxCode=idPA,
		name=companyName),
		{_viewSubject} = paymentRemittanceInformation) ~> deriveViewColumns
joinWithTokenizerDebtor select(mapColumn(
		transactionId = {_viewTransactionId},
		taxCode = body.token,
		transactionDate = {_ viewTransactionDate},
		hidden
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectDebtorUserView
JoinWithTokenizerResponse select(mapColumn(
		transactionId = {_viewTransactionId},
		taxCode = body.token,
		transactionDate = {_ viewTransactionDate},
		hidden
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectPayerUserView
addDebtorPii call(mapColumn(
		each(match(/* All input columns */ true()),
			/* Input name */ $$ = $$)
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	output(
		headers as [string,string],
		body as (token as string),
		status as string
	),
	allowSchemaDrift: true,
	format: 'rest',
	store: 'restservice',
	timeout: 30,
	requestInterval: 0,
	httpMethod: 'POST',
	headerColumnName: 'headers',
	bodyColumnName: 'body',
	statusColumnName: 'status',
	addResponseCode: true,
	responseFormat: ['type' -> 'json', 'documentForm' -> 'singleDocument']) ~> tokenizeDebtorTaxCode
selectDebtorTaxCode derive(pii = debtorEntityUniqueIdentifier) ~> addDebtorPii
deriveDebtorBody select(mapColumn(
		transactionId = {_viewTransactionId},
		debtor = _viewDebtor,
		eventId,
		payee = payee,
		subject = {_viewSubject},
		amount,
		refNumberValue = {_viewRefValue},
		refNumberType = {_viewRefType}
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectCartItemView
joinWithTokenizerDebtor derive({_viewDebtor} = @(taxCode=body.token,
		name=debtorFullName)) ~> deriveDebtorBody
selectTaxCode derive(pii = {_viewPayerTaxCode}) ~> addPayerPii
addPayerPii call(output(
		headers as [string,string],
		body as (token as string),
		status as string
	),
	allowSchemaDrift: true,
	format: 'rest',
	store: 'restservice',
	timeout: 30,
	requestInterval: 0,
	httpMethod: 'POST',
	headerColumnName: 'headers',
	bodyColumnName: 'body',
	statusColumnName: 'status',
	addResponseCode: true,
	requestFormat: ['type' -> 'json'],
	responseFormat: ['type' -> 'json', 'documentForm' -> 'documentPerLine']) ~> tokenizePayerData
JoinWithTokenizerResponse derive(payer = @(taxCode=body.token,
		name={_viewPayerName})) ~> derivedPayerBody
derivedPayerBody select(mapColumn(
		transactionId = {_viewTransactionId},
		transactionDate = {_ viewTransactionDate},
		rnn = {_viewRnn},
		authCode,
		fee,
		payer,
		walletInfo = _viewWalletInfo,
		pspName = {_viewPsp},
		origin = serviceIdentifier,
		totalNotice,
		isCart
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectGeneralViewData
txToEventDerive select(mapColumn(
		transactionId = ident_dominio
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectConvertedFields
pmPostgresRead derive(timestamp = inserted_timestamp) ~> txToEventDerive
bizCosmosRead, selectConvertedFields union(byName: true)~> uniteFlows
deriveViewColumns select(mapColumn(
		debtorEntityUniqueIdentifier,
		iuv,
		paymentMethod,
		eventId,
		totalNotice,
		amount,
		paymentRemittanceInformation,
		authCode,
		payerFullName,
		debtorFullName,
		serviceIdentifier,
		fee,
		{_viewTransactionId},
		{_ viewTransactionDate},
		{_viewRefType},
		{_viewRefValue},
		{_viewRnn},
		{_viewPayerName},
		{_viewPayerTaxCode},
		{_viewWalletInfo},
		{_viewPsp},
		hidden,
		isCart,
		{_viewPayee} = _viewPayee,
		{_viewSubject}
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectDataToSave
selectDataToSave select(mapColumn(
		{_viewPayerTaxCode},
		eventId
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectTaxCode
tokenizePayerData, selectDataToSave join(selectTaxCode@eventId == selectDataToSave@eventId,
	joinType:'inner',
	matchType:'exact',
	ignoreSpaces: false,
	broadcast: 'auto')~> JoinWithTokenizerResponse
tokenizeDebtorTaxCode, selectDataToSave join(selectDataToSave@eventId == selectDataToSave@eventId,
	joinType:'inner',
	matchType:'exact',
	ignoreSpaces: false,
	broadcast: 'auto')~> joinWithTokenizerDebtor
selectDataToSave select(mapColumn(
		debtorEntityUniqueIdentifier,
		eventId
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> selectDebtorTaxCode
selectDebtorUserView sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		id as string,
		transactionId as string,
		taxCode as string,
		transactionDate as string,
		hidden as string
	),
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/taxCode'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> debtorUserViewSink
selectPayerUserView sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		id as string,
		transactionId as string,
		taxCode as string,
		transactionDate as string,
		hidden as string
	),
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/taxCode'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> payerUserViewSink
selectCartItemView sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		eventId as string,
		amount as double,
		subject as string,
		transactionId as string,
		payee as (name as string, taxCode as string),
		debtor as (name as string, taxCode as string),
		refNumberValue as string,
		refNumberType as string
	),
	deletable:false,
	insertable:true,
	updateable:false,
	upsertable:false,
	format: 'document',
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> cartItemView
selectGeneralViewData sink(allowSchemaDrift: true,
	validateSchema: false,
	input(
		transactionId as string,
		rrn as string,
		authCode as string,
		pspName as string,
		transactionDate as string,
		walletInfo as (accountHolder as string, brand as string, blurredNumber as string),
		payer as (name as string, taxCode as string)
	),
	deletable:false,
	insertable:true,
	updateable:true,
	upsertable:true,
	format: 'document',
	partitionKey: ['/transactionId'],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> cartGeneralViewData
