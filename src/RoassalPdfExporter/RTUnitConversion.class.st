"
I am a class utility to convert values from smalltalk to the pdf in Artefact
"
Class {
	#name : #RTUnitConversion,
	#superclass : #RTObject,
	#category : #'RoassalPdfExporter-Core'
}

{ #category : #'as yet unclassified' }
RTUnitConversion class >> pixelToMm: aNumber [
	^aNumber * 0.2645833333333
]

{ #category : #'as yet unclassified' }
RTUnitConversion class >> ptToMm: aNumber [
	^aNumber*2.834645669
]
