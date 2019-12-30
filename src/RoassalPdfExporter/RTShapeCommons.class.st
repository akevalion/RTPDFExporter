"
I am a class utility to get some properties from Actifact.
"
Class {
	#name : #RTShapeCommons,
	#superclass : #RTObject,
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #'as yet unclassified' }
RTShapeCommons class >> getPDFBorderColor: aShape [
	((aShape strokePaint) isNil)
		ifTrue: [^self getPDFFillColor: aShape]
		ifFalse:[^(PDFColor 
					r: (aShape strokePaint) red *255
					g: (aShape strokePaint) green  *255
					b: (aShape strokePaint) blue *255
					)].
]

{ #category : #'as yet unclassified' }
RTShapeCommons class >> getPDFFillColor: aShape [
	((aShape color) isNil)
		ifTrue: [^(PDFColor 
					r: 0
					g: 0
					b: 0
					)]
		ifFalse:[^(PDFColor 
					r: (aShape color) red *255
					g: (aShape color) green  *255
					b: (aShape color) blue *255
					)].
]
