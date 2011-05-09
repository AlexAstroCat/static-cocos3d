/*
 * CC3PODMaterial.mm
 *
 * $Version: cocos3d 0.5.2 (f3df37821a3f) on 2011-03-13 $
 * Author: Bill Hollings
 * Copyright (c) 2010-2011 The Brenwill Workshop Ltd. All rights reserved.
 * http://www.brenwill.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * http://en.wikipedia.org/wiki/MIT_License
 * 
 * See header file CC3PODMaterial.h for full API documentation.
 */

extern "C" {
	#import "CC3Foundation.h"	// extern must be first, since foundation also imported via other imports
}
#import "CC3PODMaterial.h"
#import "CC3PVRTModelPOD.h"

@interface CC3Material (TemplateMethods)
-(void) populateFrom: (CC3Material*) another;
@end


@implementation CC3PODMaterial

@synthesize podTextureIndex;

-(int) podIndex {
	return podIndex;
}

-(void) setPodIndex: (int) aPODIndex {
	podIndex = aPODIndex;
}

static GLfloat shininessExpansionFactor = 400.0f;

+(GLfloat) shininessExpansionFactor {
	return shininessExpansionFactor;
}

+(void) setShininessExpansionFactor: (GLfloat) aFloat {
	shininessExpansionFactor = aFloat;
}

-(id) initAtIndex: (int) aPODIndex fromPODResource: (CC3PODResource*) aPODRez {
	SPODMaterial* psm = (SPODMaterial*)[aPODRez materialPODStructAtIndex: aPODIndex];
	LogTrace(@"Creating %@ at index %i from %@", [self class], aPODIndex, NSStringFromSPODMaterial(psm));
	if ( (self = [super initWithName: [NSString stringWithUTF8String: psm->pszName]]) ) {
		self.podIndex = aPODIndex;
		self.ambientColor = CCC4FMake(psm->pfMatAmbient[0], psm->pfMatAmbient[1], psm->pfMatAmbient[2], psm->fMatOpacity);
		self.diffuseColor = CCC4FMake(psm->pfMatDiffuse[0], psm->pfMatDiffuse[1], psm->pfMatDiffuse[2], psm->fMatOpacity);
		self.specularColor = CCC4FMake(psm->pfMatSpecular[0], psm->pfMatSpecular[1], psm->pfMatSpecular[2], psm->fMatOpacity);
		self.shininess = psm->fMatShininess * shininessExpansionFactor;
		self.sourceBlend = GLBlendFuncFromEPODBlendFunc(psm->eBlendSrcA);
		self.destinationBlend = GLBlendFuncFromEPODBlendFunc(psm->eBlendDstA);

		// If this material has a texture, build it
		self.podTextureIndex = psm->nIdxTexDiffuse;
		if (self.podTextureIndex >= 0) {
			LogTrace(@"Attaching texture at index %i from file %@ to %@", self.podTextureIndex,
					 [NSString stringWithUTF8String: ((SPODTexture*)[aPODRez texturePODStructAtIndex: aPODIndex])->pszName],
					 [self class]);
			self.texture = [aPODRez textureAtIndex: self.podTextureIndex];
		}
	}
	return self;
}

+(id) materialAtIndex: (int) aPODIndex fromPODResource: (CC3PODResource*) aPODRez {
	return [[[self alloc] initAtIndex: aPODIndex fromPODResource: aPODRez] autorelease];
}

-(void) populateFrom: (CC3PODMaterial*) another {
	[super populateFrom: another];
	
	podIndex = another.podIndex;
	podTextureIndex = another.podTextureIndex;
}

@end
