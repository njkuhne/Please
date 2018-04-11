
[![Version](https://img.shields.io/cocoapods/v/Please.svg?style=flat)](http://cocoapods.org/pods/Please)
[![License](https://img.shields.io/cocoapods/l/Please.svg?style=flat)](http://cocoapods.org/pods/Please)
[![Platform](https://img.shields.io/cocoapods/p/Please.svg?style=flat)](http://cocoapods.org/pods/Please)

# Please
####Be Polite, be efficient. 

`Please` is a UIKit library written in `Swift` with the singular purpose of making image loading simple and less painful to developers at every level. 

## Please let me tell you a problem I have
Having worked in web and in iOS, I have envied web developers for the maturity and simplicity of the tools and conventions they get to use. Some tasks can be handled so easily that the complexity held within them is often forgotten about. While writing `Please`, I intended to make a simple task simple, and let the developer spend more time caring about higher value logic.

### A Simple Example

Meanwhile Browser-ville, 

```HTML
<img src="awesome_icon.png">
```
**Seriously! how is it that simple...**

Lets break down what the developer is asking to have done here:

1. Make space in the UI to display an image
2. Here is a URL where you can find that image (oh by the way, please append the BASE_URL here, thanks)
3. Go ahead and fetch that image from the network (and deal with any error you encounter)
4. Parse the response to verify that it is in fact an image
5. Display that image in the UI, verifying, of course, that I haven't changed the `src` in the mean time
6. Oh and if you don't mind, cache that for me to speed up future requests, cause I might use this image again...

**Thank you very much web browser... I'm telling you, envy at every step.**

How an iOS dev thinks about this problem. 

1. I need a UIImageView, I can set that up in my nib or storyboard.
2. Maybe I can use `AFNetworking` for this! they have something for image loading right?
3. Oh wait, what about cell recycling, if the cell data changes before the image is loaded, I guess I cancel the request? 
4. Okay, so what if the request fails, do I use a placeholder image or something? do I try again if the error was a lack of network? So I have to parse the errors to figure this out. 
5. I can check to see if the image data can be used to make a UIImage, that can help me sanity check the raw data.
6. Caching? nah, it will be fine, most of my assets are in an assets catalog anyways, so its not a big deal. 

As you can see, there is complex behaviour behind this simple HTML element, With one simple statement the developer can invoke complex UI and networking, and be can do so while being expressive and specific about what they want the browser to do.

### Please, rescue me!

So heres what I want to have happen.

`cell.imageView.url = URL(string: "http://mysite.io/awesome_icon.png")`

Or more likely:

`cell.imageView.url = itemModel.imageURL`

Let the system do the work, and solve the common problems just like a browser would.

This is where `Please` comes in.

## Again Please?
Stated simply, 
> Please provides a simple, expressive way to load images into a UIImageView from a network source 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Please is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Please"
```

## Author

Nicholas Kuhne, njkuhne@me.com

## License

Please is available under the MIT license. See the LICENSE file for more info.
