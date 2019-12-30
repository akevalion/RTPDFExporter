"
I am the representation of SVG Path for pdf
"
Class {
	#name : #PDFSVGElement,
	#superclass : #PDFDraw,
	#instVars : [
		'curves',
		'unit',
		'translation'
	],
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #accessing }
PDFSVGElement >> curves [
	^ curves
]

{ #category : #accessing }
PDFSVGElement >> curves: anArray [
	curves := anArray
]

{ #category : #render }
PDFSVGElement >> producePageElementCodeWith: aPDFGenerator StyleSheet: aStyleSheet [
	| com |
	^ String
		streamContents: [ :s | 
			com := PDFPathBuilder new
				stream: s;
				generator: aPDFGenerator;
				unit: unit;
				translation: translation;
				yourself.
			self curves do: [ :curve | com perform: curve first withArguments: curve second ].
			s nextPutAll: (self fillMode: aStyleSheet filled) ]
]

{ #category : #checking }
PDFSVGElement >> requiredAttributes [
	^ #(#from #curves translation unit)
]

{ #category : #accessing }
PDFSVGElement >> translation [
	^ translation
]

{ #category : #accessing }
PDFSVGElement >> translation: point [
	translation := point
]

{ #category : #accessing }
PDFSVGElement >> unit [
	^ unit
]

{ #category : #accessing }
PDFSVGElement >> unit: u [
	unit := u
]
