#!/usr/bin/env python3
import sys
import yaml
import pathlib
import re
from glob import glob

def to_kebab_case(name):
    """Convert theme name to kebab-case."""
    name = re.sub(r'[\s_]+', '-', name)
    return name.lower()

def convert_base16_to_gowall(themes_dir, output_file):
    themes_dir = pathlib.Path(themes_dir)
    output = []

    yaml_files = glob(str(themes_dir / "*.yaml"))

    for yaml_file in sorted(yaml_files):
        with open(yaml_file, 'r') as f:
            data = yaml.safe_load(f)

        scheme_name = data.get('name', 'Unknown')
        scheme_name = to_kebab_case(scheme_name)

        palette = data.get('palette', {})
        color_keys = [f'base{i:02X}' for i in range(16)]
        colors = [palette.get(key, '#000000') for key in color_keys]

        output.append({'name': scheme_name, 'colors': colors})

    with open(output_file, 'w') as f:
        yaml.dump({'themes': output}, f, default_flow_style=False, sort_keys=False)

if __name__ == '__main__':
    convert_base16_to_gowall(sys.argv[1], sys.argv[2])
