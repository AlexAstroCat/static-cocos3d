/*
 * CC3OpenGLES11Platform.h
 *
 * $Version: cocos3d 0.5-beta (eab7e651f462) on 2011-01-31 $
 * Author: Bill Hollings
 * Copyright (c) 2011 The Brenwill Workshop Ltd. All rights reserved.
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
 */

/** @file */	// Doxygen marker

#import "CC3OpenGLES11StateTracker.h"


#pragma mark -
#pragma mark CC3OpenGLES11Platform

/**
 * CC3OpenGLES11Platform manages trackers that read and remember platform characteristics,
 * capabilities and limits. None of the platform trackers attempt to update any values.
 */
@interface CC3OpenGLES11Platform : CC3OpenGLES11StateTrackerManager {
	CC3OpenGLES11StateTrackerInteger* maxLights;
	CC3OpenGLES11StateTrackerInteger* maxClipPlanes;
	CC3OpenGLES11StateTrackerInteger* maxTextureChannels;
}

/** Reads the number of lights available, through GL parameter GL_MAX_LIGHTS. */
@property(nonatomic, retain) CC3OpenGLES11StateTrackerInteger* maxLights;

/** Reads the number of clip planes available, through GL parameter GL_MAX_CLIP_PLANES. */
@property(nonatomic, retain) CC3OpenGLES11StateTrackerInteger* maxClipPlanes;

/** Reads the number of texture channels available, through GL parameter GL_MAX_TEXTURE_UNITS. */
@property(nonatomic, retain) CC3OpenGLES11StateTrackerInteger* maxTextureChannels;

@end
