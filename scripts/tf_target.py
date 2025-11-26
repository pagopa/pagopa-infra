import re
import argparse


def get_target_from_file(file_path):
  with open(file_path, 'r') as file:
    content = file.read()

  # resource regex
  pattern_resource = r'resource\s+"([^"]+)"\s+"([^"]+)"'
  resources = re.findall(pattern_resource, content)

  # Regex per trovare i moduli
  pattern_module = r'module\s+"([^"]+)"'
  modules = re.findall(pattern_module, content)

  # generate target list
  target = []
  for r_type, r_name in resources:
    target.append(f'"{r_type}.{r_name}"')
  for m_name in modules:
    target.append(f'"module.{m_name}"')

  return target


def main():
  parser = argparse.ArgumentParser(description='Get target from terraform file')
  parser.add_argument('file_path', help='Path to tf file')
  args = parser.parse_args()

  target_list = get_target_from_file(args.file_path)

  # print all targets on a single line
  print(' '.join([f'-target={target}' for target in target_list]))


if __name__ == '__main__':
  main()
