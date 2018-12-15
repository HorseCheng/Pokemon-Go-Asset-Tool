<!-- define variables -->
[1.1]: http://i.imgur.com/M4fJ65n.png (ATTENTION)

POGOProtos [![Build Status](https://travis-ci.org/Furtif/POGOProtos.svg?branch=master)](https://travis-ci.org/Furtif/POGOProtos) [![Maintainability](https://api.codeclimate.com/v1/badges/f4fbd03daa49a667d1b7/maintainability)](https://codeclimate.com/github/Furtif/POGOProtos/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/f4fbd03daa49a667d1b7/test_coverage)](https://codeclimate.com/github/Furtif/POGOProtos/test_coverage)  [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/rocketbot)
===================

![alt text][1.1] <strong><em>`The contents of this repo are a proof of concept and are for educational use only`</em></strong>![alt text][1.1]<br/>

This repository contains the [ProtoBuf](https://github.com/google/protobuf) `.proto` files needed to decode the PokémonGo RPC.

### Implemented messages types
 - [``Global``](https://github.com/Furtif/POGOProtos/blob/master/src/POGOProtos/Networking/Requests/RequestType.proto)
 - [``Social``](https://github.com/Furtif/POGOProtos/blob/master/src/POGOProtos/Enums/SocialAction.proto)
 - [``Quests``](https://github.com/Furtif/POGOProtos/blob/master/src/POGOProtos/Enums/QuestType.proto) 
 ### Others
 - [``Client Telemetry``](https://github.com/Furtif/POGOProtos/blob/master/src/POGOProtos/Enums/TelemetryIds.proto#L37)
 - [``Platform``](https://github.com/Furtif/POGOProtos/tree/master/src/POGOProtos/Enums/PlatformClientAction.proto)
   
### Versioning

We are following [semantic versioning](http://semver.org/) for POGOProtos.  Every version will be mapped to their current PokémonGo version.

| Version      | API           | Notes           | Extra                     |
|--------------|---------------|-----------------|---------------------------|
| 2.38.0       | 0.131.1       | Compatible      |  Protocol Buffers v3.6.1  |

### Usage

If you want to figure out the current version in an automated system, use this file.

https://raw.githubusercontent.com/Furtif/POGOProtos/master/.current-version

*Note: This file will contain pre-release versions too.*

### Preparation

Current recommended protoc version: "Protocol Buffers v3.6.1".

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

```
python compile.py cpp:
 - POGOProtos/Data/PlayerData.proto -> POGOProtos/Data/PlayerData.pb.cpp
```
```
python compile.py csharp:
 - POGOProtos/Data/PlayerData.proto -> POGOProtos/Data/PlayerData.g.cs
 ```
 ```
python compile.py go:
 - POGOProtos/Data/*.proto -> github.com/aeonlucid/pogoprotos/data
 - POGOProtos/Data/PlayerData.proto -> github.com/aeonlucid/pogoprotos/data/player_data.pb.go
```
```
python compile.py java:
 - POGOProtos/Data/*.proto -> com/github/aeonlucid/pogoprotos/Data.java
 ```
 ```
python compile.py js:
 - POGOProtos/**/*.proto -> pogoprotos.js
```
```
python compile.py objc:
 - POGOProtos/Data/PlayerData.proto -> POGOProtos/Data/PlayerData.pbobjc.m
```
```
python compile.py python:
 - POGOProtos/Data/*.proto -> pogoprotos/data/__init__.py
 - POGOProtos/Data/PlayerData.proto -> pogoprotos/data/player_data_pb2.py
```
```
python compile.py ruby:
 - POGOProtos/Data/*.proto -> pogoprotos/data.rb
 - POGOProtos/Data/PlayerData.proto -> pogoprotos/data/player_data.rb
```

### Extra information

 - Run ```python compile.py --help``` for help.
 - You can find all available languages here [https://github.com/google/protobuf](https://github.com/google/protobuf).

### Libraries

If you don't want to compile POGOProtos but instead use it directly, check out the following repository.

| Language              | Source                                                         | Status |
|-----------------------|----------------------------------------------------------------|--------|
| NodeJS                | https://github.com/pogosandbox/pogobuf                         |  OK    |
| NodeJS (pure JS)      | https://github.com/pogosandbox/node-pogo-protos                |  OK    |
| .NET (nuget pack)     | https://www.nuget.org/packages/POGOProtos.Core                 |  OK    |
| Swift                 | https://github.com/123FLO321/POGOProtos-Swift                  |  OK    |
| PHP                   | https://github.com/jaspervdm/pogoprotos-php                    |![alt text][1.1]OUTED|
| Go                    | https://github.com/pkmngo-odi/pogo-protos                      |![alt text][1.1]OUTED|
| Haskell               | https://github.com/relrod/pokemon-go-protobuf-types            |![alt text][1.1]OUTED|
| Rust                  | https://github.com/rockneurotiko/pokemon-go-protobuf-rs        |![alt text][1.1]OUTED|
| Java                  | https://github.com/pokemongo-dev-contrib/pogoprotos-java       |  OK    |

| Additional resources  | Source                                                         | Status |
|-----------------------|----------------------------------------------------------------|--------|
| Gamemaster Json       | https://github.com/pokemongo-dev-contrib/pokemongo-game-master |  OK    |

### CREDITS

 - [AeonLucid](https://github.com/AeonLucid)
 - [pogosandbox (niicojs)](https://github.com/pogosandbox)
 - [ZeChrales](https://github.com/ZeChrales)
