#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import operator
import os
import shutil
from subprocess import call

# Variables
# global_version = '0.235.x_p_obf'
global_version = 'base'
protoc_executable = "protoc"
package_name = 'POGOProtos.Rpc'
input_file = "POGOProtos.Rpc.proto"
base_file = os.path.abspath("base/vbase.proto")
protos_path = os.path.abspath("base")
gen_last_files = os.path.abspath("base/last_files")
# args
parser = argparse.ArgumentParser()
parser.add_argument("-gm", "--generate_game_master", help="Generates v2_GAME_MASTER.txt form PATH/v2_GAME_MASTER.")
parser.add_argument("-ga", "--generate_asset_digest", help="Generates ASSET_DIGEST.txt form PATH/ASSET_DIGEST.")
parser.add_argument("-l", "--lang", help="Language to produce proto single file.")
parser.add_argument("-v", "--version", help="Set version out ex:. (0.205.x)")
parser.add_argument("-o", "--out_path", help="Output path for proto single file.")
parser.add_argument("-m", "--java_multiple_files", action='store_true', help='Write each message to a separate .java file.')
parser.add_argument("-g", "--generate_only", action='store_true', help='Generates only proto compilable.')
parser.add_argument("-b", "--generate_new_base", action='store_true', help='Generates new proto base refs.')
parser.add_argument("-k", "--keep_proto_file", action='store_true', help='Do not remove .proto file after compiling.')
parser.add_argument("-gf", "--generate_proto_files", action='store_true', help='Generates base/last_files/*.proto.')
args = parser.parse_args()
# Set defaults args
lang = args.lang or "proto"
out_path = args.out_path or "out/single_file/" + lang
java_multiple_files = args.java_multiple_files
gen_only = args.generate_only
gen_files = args.generate_proto_files
version = args.version or global_version
gen_base = args.generate_new_base
keep_file = args.keep_proto_file
gen_game_master = args.generate_game_master or None
gen_asset_digest = args.generate_asset_digest or None
# Determine where path's and variables
raw_name = "v" + version + ".proto"
raw_proto_file = os.path.abspath("base/" + raw_name)
out_path = os.path.abspath(out_path)
if gen_asset_digest is not None:
    if not os.path.exists(gen_asset_digest):
        print("Binary not found.")
        exit(0)
    commands = []
    print("Try to decode " + gen_asset_digest + ".txt....")
    call(""""{0}" --version""".format(protoc_executable), shell=True)
    pogo_protos_path = './base'
    pogo_protos_target = 'POGOProtos.Rpc.AssetDigestOutProto'
    pogo_protos_template = './base/' + raw_name
    commands.append(
        """"{0}" --proto_path="{1}" --decode "{2}" {3} <{4}> {5}""".format(
            protoc_executable,
            pogo_protos_path,
            pogo_protos_target,
            pogo_protos_template,
            gen_asset_digest,
            gen_asset_digest + '.txt'
        ))
    for command in commands:
        call(command, shell=True)
    exit(0)
if gen_game_master is not None:
    if not os.path.exists(gen_game_master):
        print("Binary not found.")
        exit(0)
    commands = []
    print("Try to decode " + gen_game_master + ".txt....")
    call(""""{0}" --version""".format(protoc_executable), shell=True)
    pogo_protos_path = './base'
    pogo_protos_target = 'POGOProtos.Rpc.DownloadGmTemplatesResponseProto'
    pogo_protos_template = './base/' + raw_name
    commands.append(
        """"{0}" --proto_path="{1}" --decode "{2}" {3} <{4}> {5}""".format(
            protoc_executable,
            pogo_protos_path,
            pogo_protos_target,
            pogo_protos_template,
            gen_game_master,
            gen_game_master + '.txt'
        ))
    for command in commands:
        call(command, shell=True)
    exit(0)
# Add licenses
head = '/*\n'
head += '* Copyright 2016-2022 --=FurtiF=--.\n'
head += '*\n'
head += '* Licensed under the\n'
head += '*	Educational Community License, Version 2.0 (the "License"); you may\n'
head += '*	not use this file except in compliance with the License. You may\n'
head += '*	obtain a copy of the License at\n'
head += '*\n'
head += '*	http://www.osedu.org/licenses/ECL-2.0\n'
head += '*\n'
head += '*	Unless required by applicable law or agreed to in writing,\n'
head += '*	software distributed under the License is distributed on an "AS IS"\n'
head += '*	BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express\n'
head += '*	or implied. See the License for the specific language governing\n'
head += '*	permissions and limitations under the License.\n'
head += '*\n* Version: ' + version + '\n*\n'
head += '*/\n\n'
head += 'syntax = "proto3";\n'
head += 'package %s;\n\n' % package_name
# Clean up previous out
try:
    os.remove(out_path)
except OSError:
    pass
if out_path and os.path.exists(out_path):
    shutil.rmtree(out_path)
# Create necessary directory
if not os.path.exists(out_path):
    os.makedirs(out_path)
commands = []


def open_proto_file(main_file, head_for_files):
    new_proto_single_file = main_file.replace(raw_name, input_file)
    if os.path.exists(new_proto_single_file):
        os.unlink(new_proto_single_file)
    open_for_new = open(new_proto_single_file, 'a')
    if not gen_only:
        # Add options by language
        if java_multiple_files and lang == "java":
            head_for_files += 'option java_multiple_files = true;\n\n'
        elif lang == "cpp":
            head_for_files += 'option optimize_for = CODE_SIZE;\n\n'
    open_for_new.writelines(head_for_files)
    messages = ''
    # Delete demos
    with open(main_file, 'r') as proto_file:
        for proto_line in proto_file.readlines():
            messages += proto_line
    # check in messages basic obfuscated names...
    proto_name = ''
    for proto_line in messages.split("\n"):
        if operator.contains(proto_line, "{") and len(proto_name) == 11 and proto_name.isupper():
            if operator.contains(proto_line, "oneof "):
                print("OneOf: " + proto_name)
            elif operator.contains(proto_line, "message "):
                print("Message: " + proto_name)
            else:
                print("Enum: " + proto_name)
    # Reorder all this...
    new_base_enums = {}
    new_base_messages = {}
    new_base_as_data = False
    new_base_is_enum = False
    new_base_proto_name = ''
    new_base_data = ''
    for proto_line in messages.split("\n"):
        if proto_line.startswith("enum") or proto_line.startswith("message"):
            new_base_as_data = True
            new_base_proto_name = proto_line.split(" ")[1]
        if proto_line.startswith("enum"):
            new_base_is_enum = True
        if proto_line.startswith("message"):
            new_base_is_enum = False
        if proto_line.startswith("}"):
            new_base_data += proto_line + "\n"
            if new_base_is_enum:
                new_base_enums.setdefault(new_base_proto_name, new_base_data)
            else:
                new_base_messages.setdefault(new_base_proto_name, new_base_data)
            new_base_as_data = False
            new_base_is_enum = False
            new_base_proto_name = ''
            new_base_data = ''
        if new_base_as_data:
            new_base_data += proto_line + "\n"
    new_base_file = ''
    head_file = None
    if gen_files:
        if os.path.exists(gen_last_files):
            shutil.rmtree(gen_last_files)
        if not os.path.exists(gen_last_files):
            os.makedirs(gen_last_files)
        head_file = head_for_files.replace('*\n* Version: ' + version + '\n*\n', '*\n* Note: For references only.\n*\n')
    for p in sorted(new_base_enums):
        new_base_file += new_base_enums[p] + "\n"
        if head_file is not None:
            open_for_new_enum = open(gen_last_files + "/" + p + '.proto', 'a')
            open_for_new_enum.writelines(head_file)
            open_for_new_enum.writelines(new_base_enums[p])
            open_for_new_enum.close()
    for p in sorted(new_base_messages):
        new_base_file += new_base_messages[p] + "\n"
        if head_file is not None:
            open_for_new_message = open(gen_last_files + "/" + p + '.proto', 'a')
            open_for_new_message.writelines(head_file)
            open_for_new_message.writelines(new_base_messages[p])
            open_for_new_message.close()
    # find imports ..
    if head_file is not None:
        for p in sorted(new_base_messages):
            if os.path.exists(gen_last_files + "/" + p + '.proto'):
                os.remove(gen_last_files + "/" + p + '.proto')
            open_for_new_message = open(gen_last_files + "/" + p + '.proto', 'a')
            open_for_new_message.writelines(head_file)
            includes = []
            for message in new_base_messages[p].split("\n"):
                if message.startswith("message") or message.startswith("enum") or message.startswith("}"):
                    continue
                elif message.startswith('\tmap<'):
                    v = message.split("map<")[1].strip().split('>')[0].strip().replace(",", "")
                    v1 = v.split(" ")[0].strip() + '.proto'
                    v2 = v.split(" ")[1].strip() + '.proto'
                    if os.path.exists(gen_last_files + "/" + v1):
                        if v1 not in includes:
                            includes.append(v1)
                    if os.path.exists(gen_last_files + "/" + v2):
                        if v2 not in includes:
                            includes.append(v2)
                elif message.startswith('\trepeated') or message.startswith('\t\trepeated') or message.startswith(
                        '\t\t\trepeated'):
                    file_for_includes = message.split(" ")[1].strip() + '.proto'
                    if os.path.exists(gen_last_files + "/" + file_for_includes) and file_for_includes not in includes:
                        includes.append(file_for_includes)
                else:
                    file_for_includes = message.split(" ")[0].strip() + '.proto'
                    if os.path.exists(gen_last_files + "/" + file_for_includes) and file_for_includes not in includes:
                        includes.append(file_for_includes)
            if len(includes) > 0:
                files_inc = ''
                for file in includes:
                    if file == 'ITEM.proto':
                        continue
                    files_inc += 'import "' + file + '";\n'
                if files_inc != '':
                    open_for_new_message.writelines(files_inc + '\n')
            open_for_new_message.writelines(new_base_messages[p])
            open_for_new_message.close()
    messages = new_base_file
    open_for_new.writelines(messages[:-1])
    open_for_new.close()
    add_command_for_new_proto_file(new_proto_single_file)


def add_command_for_new_proto_file(file):
    command_out_path = os.path.abspath(out_path)
    options = ''
    arguments = ''
    if lang == 'js':
        options = 'import_style=commonjs,binary'
    elif lang == 'swift':
        arguments = '--swift_opt=Visibility=Public'
    # elif lang == 'csharp':
    #    arguments = '--csharp_opt=file_extension=.g.cs --csharp_opt=base_namespace'
    # elif lang == 'dart':
    #    arguments = '--plugin "pub run protoc_plugin"'
    # elif lang == 'lua':
    #    arguments = '--plugin=protoc-gen-lua="../ProtoGenLua/plugin/build.bat"'
    elif lang == 'go':
        options = 'plugins=grpc'
    commands.append(
        """{0} --proto_path={1} --{2}_out={3}:{4} {5} {6}""".format(
            protoc_executable,
            protos_path,
            lang,
            options,
            command_out_path,
            arguments,
            file
        )
    )


compile_ext = 'v' + version + '.proto'
if lang == 'python':
    package_name = package_name.replace('.', '_')
    input_file = package_name + '.proto'
if gen_base and gen_files and gen_only:
    if lang == 'proto':
        lang = 'cpp'
    compile_ext += ', remaster_all()'
if gen_base:
    compile_ext += ', base()'
if gen_only:
    compile_ext += ', generate_new()'
if gen_files:
    compile_ext += ', generate_files()'
compile_ext += ', out_mode(' + lang + ')'
print("Compile: " + compile_ext + ", please await...")
print(package_name + " " + version)
call(""""{0}" --version""".format(protoc_executable), shell=True)
open_proto_file(raw_proto_file, head)
generated_file = raw_proto_file.replace(raw_name, input_file)
descriptor_file = generated_file.replace(".proto", ".desc")
descriptor_file_arguments = ['--include_source_info', '--include_imports']
try:
    os.unlink(descriptor_file)
except OSError:
    pass
commands.append(
    """"{0}" --proto_path="{1}" --descriptor_set_out="{2}" {3} {4}""".format(
        protoc_executable,
        protos_path,
        descriptor_file,
        ' '.join(descriptor_file_arguments),
        generated_file))
if not gen_only and not gen_base and not gen_files and not lang == 'proto':
    # Compile commands
    for command in commands:
        call(command, shell=True)
    # Add new desc version
    descriptor_file = generated_file.replace(".proto", ".desc")
    shutil.move(descriptor_file, out_path)
# Add new proto version
if gen_only:
    shutil.copy(generated_file, protos_path + '/v' + version + '.proto')
# New base for next references names
if gen_base:
    try:
        os.unlink(base_file)
    except OSError:
        pass
    shutil.copy(generated_file, base_file)
if keep_file or lang == "proto":
    shutil.move(generated_file, out_path)

# Clean genererated and unneded files
try:
    os.unlink(generated_file)
except OSError:
    pass
print("Done!")
