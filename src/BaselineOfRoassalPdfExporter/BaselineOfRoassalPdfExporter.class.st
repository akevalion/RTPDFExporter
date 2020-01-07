"
I am a baseline for this project
"
Class {
	#name : #BaselineOfRoassalPdfExporter,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoassalPdfExporter
}

{ #category : #baselines }
BaselineOfRoassalPdfExporter >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [			
			spec
    			baseline: 'Artefact'
    			with: [ spec repository: 'github://pharo-contributions/Artefact:master/src' ].
			spec package: 'RoassalPdfExporter' with: [ spec requires: #('Artefact') ]. 
			spec group: 'default' with: #('RoassalPdfExporter').
		]
]
