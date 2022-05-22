<!-- define variables -->
[1.1]: http://i.imgur.com/M4fJ65n.png (ATTENTION)

POGOProtos [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/rocketbot) [![Python script](https://github.com/Furtif/POGOProtos/actions/workflows/python-app.yml/badge.svg?branch=master)](https://github.com/Furtif/POGOProtos/actions) [![NuGet](https://img.shields.io/nuget/v/POGOProtos.Core.svg?maxAge=60)](https://www.nuget.org/packages/POGOProtos.Core) [![POGOProtos.Core on fuget.org](https://www.fuget.org/packages/POGOProtos.Core/badge.svg)](https://www.fuget.org/packages/POGOProtos.Core)
=========


![alt text][1.1] <strong><em>`The contents of this repo are a proof of concept and are for educational use only`</em></strong>![alt text][1.1]<br/>

---

This repository contains the [ProtoBuf](https://github.com/google/protobuf) `.proto` files needed to decode the PokémonGo RPC.

---

### Versioning
We are following [semantic versioning](http://semver.org/) for POGOProtos-Private.  Every version will be mapped to their current PokémonGo version.

| Version                                                                    | Base                                                                                 | Notes                  | Extra                    |
|----------------------------------------------------------------------------|--------------------------------------------------------------------------------------|------------------------|--------------------------|
| [2.56.4](https://github.com/Furtif/POGOProtos/raw/master/.current-version) | [v0.237.0](https://github.com/Furtif/POGOProtos/blob/master/base/vbase_proto2.proto) | **Proto2** Compilable (Mixed) | Protocol Buffers v3.20.1 |
| [2.56.4](https://github.com/Furtif/POGOProtos/raw/master/.current-version) | [v0.237.0](https://github.com/Furtif/POGOProtos/blob/master/base/vbase.proto)        | **Proto3** Compilable (Mixed) | Protocol Buffers v3.20.1 |
| [2.54.1](https://github.com/Furtif/POGOProtos/raw/master/.current-version) | [v0.205.x](https://github.com/Furtif/POGOProtos/blob/master/base/v0.205.x.proto)     | **last 100% clean** (_[/base/v0.205.x.proto](https://github.com/Furtif/POGOProtos/blob/master/base/v0.205.x.proto)_)  | Protocol Buffers v3.15.8 |

### Addons

| Additional resources as *.json files | Source                                                                               | Status
|------------------------|--------------------------------------------------------------------------------------|--------
| [v2_GAME_MASTER.json](https://raw.githubusercontent.com/Furtif/POGOProtos/master/GM/v2_GAME_MASTER.json) | [Root](https://github.com/Furtif/POGOProtos/tree/master/GM)                                   |  OK
| [GAME_MASTER.json](https://raw.githubusercontent.com/Furtif/POGOProtos/master/GM/GAME_MASTER.json) | [Root](https://github.com/Furtif/POGOProtos/tree/master/GM)                                   |  OK
| [ASSET_DIGEST.json](https://raw.githubusercontent.com/Furtif/POGOProtos/master/GM/ASSET_DIGEST.json) | [Root](https://github.com/Furtif/POGOProtos/tree/master/GM)                                   |  OK

| Additional resources as *.txt files (_[Decode mode by script](https://github.com/Furtif/POGOProtos#decode-game-master-or-asset-digest)_)| Source                                                                               | Status
|------------------------|--------------------------------------------------------------------------------------|--------
| [v2_GAME_MASTER.txt](https://raw.githubusercontent.com/Furtif/POGOProtos/master/GM/v2_GAME_MASTER.txt) | [Root](https://github.com/Furtif/POGOProtos/tree/master/GM)                                   |  OK
| [ASSET_DIGEST.txt](https://raw.githubusercontent.com/Furtif/POGOProtos/master/GM/ASSET_DIGEST.txt) | [Root](https://github.com/Furtif/POGOProtos/tree/master/GM)                                   |  OK

| Additional resources as *.xml files | Source                                                                               | Status
|------------------------|--------------------------------------------------------------------------------------|--------
| [v2_GAME_MASTER.xml](https://raw.githubusercontent.com/Furtif/POGOProtos/master/GM/v2_GAME_MASTER.xml) | [Root](https://github.com/Furtif/POGOProtos/tree/master/GM)                                   |  OK
| [ASSET_DIGEST.xml](https://raw.githubusercontent.com/Furtif/POGOProtos/master/GM/ASSET_DIGEST.xml) | [Root](https://github.com/Furtif/POGOProtos/tree/master/GM)                                   |  OK

### Usage
If you want to figure out the current version in an automated system, use this file.
[.current-version](https://github.com/Furtif/POGOProtos/raw/master/.current-version)
*Note: This file will contain pre-release versions too.*

```
usage: compile_base.py [-h] [-gm GENERATE_GAME_MASTER]
                       [-ga GENERATE_ASSET_DIGEST] [-l LANG] [-v VERSION]
                       [-o OUT_PATH] [-m] [-g] [-b] [-k] [-gf]

optional arguments:
  -h, --help            show this help message and exit
  -gm GENERATE_GAME_MASTER, --generate_game_master GENERATE_GAME_MASTER
                        Generates v2_GAME_MASTER.txt form PATH/v2_GAME_MASTER.
  -ga GENERATE_ASSET_DIGEST, --generate_asset_digest GENERATE_ASSET_DIGEST
                        Generates ASSET_DIGEST.txt form PATH/ASSET_DIGEST.
  -l LANG, --lang LANG  Language to produce proto single file.
  -v VERSION, --version VERSION
                        Set version out ex:. (0.205.x)
  -o OUT_PATH, --out_path OUT_PATH
                        Output path for proto single file.
  -m, --java_multiple_files
                        Write each message to a separate .java file.
  -g, --generate_only   Generates only proto compilable.
  -b, --generate_new_base
                        Generates new proto base refs.
  -k, --keep_proto_file
                        Do not remove .proto file after compiling.
  -gf, --generate_proto_files
                        Generates base/last_files/*.proto.
                        
```

### Preparation
Current recommended protoc version: "Protocol Buffers v3.20.1".
You can find download links [here](https://github.com/google/protobuf/releases).

#### Windows
Be sure to add `protoc` to your environmental path.

#### *nix
Ensure that you have the newest version of `protoc` installed.

#### OS X
Use `homebrew` to install `protobuf ` with `brew install --devel protobuf`.

### Compilation
The compilation creates output specifically for the target language, i.e. respecting naming conventions, etc.  
This is an example of how the generated code will be organized:

##### Compile vx.xxx.x.proto [depending on the version chosen, or uses -v 0.205.x (or other version present into base folder >= 0.175.x)](https://github.com/Furtif/POGOProtos/blob/master/compile_base.py#L12)

 * _Note: the *.desc file is auto created in this function_

```
python compile_base.py -l cpp -k -v base:
 - vbase.proto -> out/single_file/cpp/POGOProtos.Rpc.desc
 -                -> out/single_file/cpp/POGOProtos.Rpc.pb.cc
 -                -> out/single_file/cpp/POGOProtos.Rpc.pb.h
 -                -> out/single_file/cpp/POGOProtos.Rpc.proto
```

##### Same similar outputs up but others langs:

```
  python compile_base.py -l csharp -k
  python compile_base.py -l java -k
  python compile_base.py -l js -k
  python compile_base.py -l python -k
  python compile_base.py -l php -k
  python compile_base.py -l objc -k
  python compile_base.py -l ruby -k
  * python compile_base.py -l swift -k
  * python compile_base.py -l go -k
  * python compile_base.py -l lua -k
  * python compile_base.py -l dart -k
```

_* = Needs plugins_

##### Decode Game Master or Asset Digest:

```
  python compile_base.py -gm [./v2_GAME_MASTER] (out as same bin name *.txt)
  python compile_base.py -ga [./ASSET_DIGEST] (out as same bin name *.txt)
```
---

### Initial
- [AeonLucid](https://github.com/AeonLucid/POGOProtos)
