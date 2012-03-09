#Purpose
Alot of images I would get from designers were saved in CMYK instead of RGB, poorly optimized, or had color profiles attatched to them. Color profiles do not work consistently across browsers: removing them works best for my workflow. The easiest way I found to remove color profiles before writing this little tool was to open the image in Preview.app and save it. I noticed that the filesize was generally much smaller than the non-Preview.app saved file.

I wrote this tool to:  
* convert CMYK images to RGB
* strip color profiles 
* get some of the file optimization benefits that Preview.app provided.

#Installation
* copy image2web to /usr/bin or other bin directory
* `color_fix.bash` uses optipng. Install using `brew install optipng`

#Usage

	color_fix.bash ~/Sites/websites/images
	image2web ~/Sites/websites/images/background.jpg
	image2web ~/Sites/websites/images/tile.png
