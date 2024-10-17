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

{ #category : 'adding' }
SportClub >> addSportsperson: anAthlete [ 
    members add: anAthlete.


]

{ #category : 'display' }
SportClub >> displayAllMembers [ 
    members do: [ :athlete | athlete displayInformationInTranscript ].
]

{ #category : 'display' }
SportClub >> displayClubInfo [ 
    ^ String streamContents: [ :stream |
        stream
            nextPutAll: 'Назва клубу: '; nextPutAll: name; cr;
            nextPutAll: 'Члени клубу: '; cr.
        members do: [ :athlete |
            stream nextPutAll: athlete displayInformation.
            stream cr.
        ].
    ].

]

{ #category : 'printing' }
SportClub >> displayClubInfoTranscrip [ 
    Transcript show: 'Назва клубу: ', name; cr.
    Transcript show: 'Члени клубу: '; cr.
    members do: [ :athlete | Transcript show: athlete displayInformation; cr ].

]

{ #category : 'finding/searching' }
SportClub >> findSportspersonByLastName: lastName [ 
    ^ members detect: [ :athlete | athlete lastName = lastName ] ifNone: [ nil ].

]

{ #category : 'initialization' }
SportClub >> initializeWithName: clubName [ 
    name := clubName.
    members := OrderedCollection new.

]

{ #category : 'accessing' }
SportClub >> members [ 
    ^ members.
]

{ #category : 'accessing' }
SportClub >> members: aCollection [ 
    members := aCollection.

]

{ #category : 'accessing' }
SportClub >> name [ 
    ^ name.
]

{ #category : 'accessing' }
SportClub >> name: aName [ 
    name := aName.
]

{ #category : 'printing' }
SportClub >> printCategoryInfo: aCategory [ 
    Transcript show: 'Список спортсменів категорії: ', aCategory; cr.

    (members select: [ :athlete | athlete sportType = aCategory ]) do: [ :athlete |
        Transcript show: athlete displayInformation; cr.
    ].



]

{ #category : 'printing' }
SportClub >> printTopScorers [ 
    | topScorers |
    
    topScorers := self topScorers.
    
    Transcript show: 'Топ гравці за кількістю забитих голів:'; cr.
    
    topScorers do: [ :athlete |
        Transcript show: athlete displayInformation; cr.
    ].

]

{ #category : 'adding' }
SportClub >> removeSportsperson: anAthlete [ 
    members remove: anAthlete ifAbsent: [ Transcript show: 'Спортсмен не знайдений у клубі.'; cr ].

]

{ #category : 'as yet unclassified' }
SportClub >> topRankedTennisPlayers: aRank [ 
    ^ (members select: [ :athlete | 
        (athlete isKindOf: TennisPlayer) and: [ athlete worldRanking <= aRank ]
    ]).

]

{ #category : 'display' }
SportClub >> topRankedTennisPlayersInfo: aRank [ 
    | topTennisPlayers |
    
    topTennisPlayers := self topRankedTennisPlayers: aRank.
    
    ^ String streamContents: [ :stream |
        stream nextPutAll: 'Тенісисти з топ-', aRank asString, ' світового рейтингу:'; cr.
        
        topTennisPlayers do: [ :athlete |
            stream nextPutAll: athlete displayInformation; cr.
        ].
    ].

]

{ #category : 'as yet unclassified' }
SportClub >> topScorers [ 
    | sortedFootballers |

    sortedFootballers := (members select: [ :athlete | athlete isKindOf: FootballPlayer ]) copy.

    sortedFootballers sort: [ :a :b | a goalsScored > b goalsScored ].

    ^ sortedFootballers first: (3 min: sortedFootballers size).


]

{ #category : 'display' }
SportClub >> topScorersInfo [ 
    ^ String streamContents: [ :stream |
        | topScorers |
        
        topScorers := self topScorers.
        
        stream nextPutAll: 'Топ гравці за кількістю забитих голів:'; cr.
        
        topScorers do: [ :athlete |
            stream nextPutAll: athlete displayInformation; cr.
        ].
    ].

]

{ #category : 'accessing' }
SportClub >> totalEarnings [ 
    ^ members inject: 0 into: [ :sum :athlete | sum + athlete totalEarnings ].

]

{ #category : 'accessing' }
SportClub >> totalMembers [ 
    ^ members size.
]
