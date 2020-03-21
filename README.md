## Databank

### iOS app to display data from [Danmark Statistic](https://www.dst.dk/en/Statistik/statistikbanken/api)

#### Dependencies

This app has only one dependency: [Kingfisher](https://github.com/onevcat/Kingfisher)

It is installed through **Swift Package Manager**

#### Architecture

The app follows the VIPER-C architecture

#### Problems encounters

Not all graphs (tables with data) are shown due to the different mandatory variables the API requires - these mandatory variables are not always the same. I have tried a universal aproach but was not successful

The app is missing animations, but otherwise I made it to resemble a little bit a file cabinet, where each subject and table category can be seen as a stack of folders (something similar to Apple Wallet, although not that nice).