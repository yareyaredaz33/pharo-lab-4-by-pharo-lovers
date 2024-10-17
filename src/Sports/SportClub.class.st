"
""клас спортивного клубу""
"
Class {
	#name : 'SportClub',
	#superclass : 'Object',
	#instVars : [
		'name',
		'members'
	],
	#category : 'Sports',
	#package : 'Sports'
}

{ #category : 'initialization' }
SportClub >> initializeWithName: clubName [ [
    name := clubName.
    members := OrderedCollection new.
]
]

{ #category : 'accessing' }
SportClub >> members [ [
    ^ members.
]
]

{ #category : 'accessing' }
SportClub >> members: aCollection [ [
    members := aCollection.
]
]

{ #category : 'accessing' }
SportClub >> name [ [
    ^ name.
]
]

{ #category : 'accessing' }
SportClub >> name: aName [ [
    name := aName.
]
]
