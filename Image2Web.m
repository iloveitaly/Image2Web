#import <AppKit/AppKit.h>

#import "unistd.h"

/*
 File Types:
 
 typedef enum _NSBitmapImageFileType {
	 NSTIFFFileType,
	 NSBMPFileType,
	 NSGIFFileType,
	 NSJPEGFileType,
	 NSPNGFileType,
	 NSJPEG2000FileType
 } NSBitmapImageFileType;
 */

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSArray *arguments = [[NSProcessInfo processInfo] arguments];
	
	if([arguments count] == 1) {
		printf("Invalid # of arguments.\n");
		return 1;
	}
	
	NSString *inputImagePath = [arguments objectAtIndex:1];
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:inputImagePath];
	NSString *extension = [inputImagePath pathExtension];
	
	NSString *outputImagePath;
	int outputType;
	
	if([extension isEqualToString:@"png"]) {
		outputType = NSPNGFileType;
	} else if([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"jpeg"]) {
		outputType = NSJPEGFileType;
	} else {
		printf("Invalid extension");
		exit(1);
	}

	NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
	[rep setProperty:NSImageColorSyncProfileData withValue:nil]; // remove color profile
	NSData *outputImageData = [rep representationUsingType:outputType properties:nil];
	
	switch([arguments count]) {
		case 2:
			// then only input file is specified
			// ouput to std ouput
			
			outputImagePath = inputImagePath;
			[outputImageData writeToFile:outputImagePath atomically:YES];
			
			break;
		case 3:
			// then an output file is specified
			outputImagePath = [arguments objectAtIndex:2];
			
			if([outputImagePath isEqualToString:@"-"]) { // then output to stdout
				write(STDOUT_FILENO, [outputImageData bytes], [outputImageData length]);
			} else {
				[outputImageData writeToFile:outputImagePath atomically:YES];
			}
				
			break;
	}

    [pool release];
    return 0;
}
