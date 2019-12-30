"
I am a subclass of format to define the dimension of the entire page of the pdf file
"
Class {
	#name : #PDFCustomFormat,
	#superclass : #PDFFormat,
	#instVars : [
		'pdfVisitor',
		'dimensionVisitor',
		'document'
	],
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #defaults }
PDFCustomFormat >> defaultSize [
	^ 0 point @ 0 point
]

{ #category : #accessing }
PDFCustomFormat >> size: aSize [
	size:=aSize
]
