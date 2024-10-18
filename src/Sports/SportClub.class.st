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

{ #category : 'as yet unclassified' }
SportClub >> athleteNames [ 
    "Список прізвищ спортсменів для відображення в вікні"
    ^ members collect: [ :athlete | athlete lastName ].

]

{ #category : 'as yet unclassified' }
SportClub >> createMenuMorph [ 
    | menu |

    menu := MenuMorph new.

    menu add: 'Додати нового спортсмена' action: [ self addAthleteFromDialog ].
    menu add: 'Вивести інформацію про всіх спортсменів' action: [ self showAllAthletes ].
    menu add: 'Вивести тенісистів з топ-10' action: [ self showTopTennisPlayers ].
    menu add: 'Найкращі голеадори' action: [ self showTopScorers ].

    ^ menu
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

{ #category : 'review contracts' }
SportClub >> highestPaidAthlete [ 
    ^ members detect: [ :athlete | athlete totalEarnings = (members collect: [ :each | each totalEarnings ]) max ].


]

{ #category : 'initialization' }
SportClub >> initializeWithName: clubName [ 
    name := clubName.
    members := OrderedCollection new.

]

{ #category : 'review contracts' }
SportClub >> manualReviewContracts [
    ^ String streamContents: [ :stream |
        stream nextPutAll: 'Перегляд контрактів...'; cr.
        self reviewContracts.

        stream nextPutAll: 'Найоплачуваніший спортсмен: '; cr.
        stream nextPutAll: (self highestPaidAthlete displayInformation); cr.
    ].

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

{ #category : 'as yet unclassified' }
SportClub >> openMainWindow [ 
    | window athleteListPane |

    window := SystemWindow labelled: 'Спортивний клуб - ', name.
  "  window label: 'Спортивний клуб - ', name."

  "  ""Вікно для відображення спортсменів""
    athleteListPane := PluggableListMorph on: self list: #athleteNames selection: nil.
    window addMorph: athleteListPane frame: (0 @ 0 corner: 1 @ 0.6).
"
    "Додаємо меню"
   " window addMorph: (self createMenuMorph) frame: (0 @ 0.6 corner: 1 @ 1)."

    window openInWorld.

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

{ #category : 'removing' }
SportClub >> removeAthletesMatching: aBlock [ 
    | initialCount removedAthletes resultMessage |
    
    initialCount := members size.
    
    removedAthletes := members select: aBlock.
    
    members := members reject: aBlock.
    
    resultMessage := String streamContents: [ :stream |
        (removedAthletes isEmpty)
            ifTrue: [ stream nextPutAll: 'Нікого не видалено'; cr ]
            ifFalse: [
                stream nextPutAll: 'Видалено спортсменів: '; cr.
                removedAthletes do: [ :athlete | stream nextPutAll: athlete lastName; cr ].
            ].
    ].
    
    ^ resultMessage.



]

{ #category : 'removing' }
SportClub >> removeSportsperson: anAthlete [ 
    members remove: anAthlete ifAbsent: [ Transcript show: 'Спортсмен не знайдений у клубі.'; cr ].

]

{ #category : 'review contracts' }
SportClub >> reviewContracts [ 
    ^ String streamContents: [ :stream |
        members do: [ :athlete |
            stream nextPutAll: athlete displayInformation; cr.
            stream nextPutAll: 'Заробітки: '; nextPutAll: athlete totalEarnings asString; cr.
        ].
    ].
]

{ #category : 'review contracts' }
SportClub >> reviewContractsAtSpecificTime: currentTimeString [
	^ String streamContents: [ :stream |
		stream nextPutAll: 'Перегляд контрактів...'; cr.
		self reviewContracts.

		stream nextPutAll: 'Найоплачуваніший спортсмен: '; cr.
		stream nextPutAll: (self highestPaidAthlete displayInformation); cr.
	].


]

{ #category : 'as yet unclassified' }
SportClub >> showAllAthletes [ 
    Transcript show: 'Список всіх спортсменів: '; cr.
    members do: [ :athlete |
        Transcript show: athlete lastName, ', ', athlete nationality; cr.
    ].
]

{ #category : 'as yet unclassified' }
SportClub >> showTopScorers [ 
    | topScorers |
    topScorers := self findTopScorers.
    Transcript show: 'Найкращі голеадори:'; cr.
    topScorers do: [ :player | 
        Transcript show: player lastName, ', Голи: ', player goals asString; cr.
    ].
]

{ #category : 'as yet unclassified' }
SportClub >> showTopTennisPlayers [ 
    | topTennisPlayers |
    topTennisPlayers := self findTopRankedTennisPlayers.
    Transcript show: 'Тенісисти з топ-10 світового рейтингу:'; cr.
    topTennisPlayers do: [ :player | 
        Transcript show: player lastName, ', Рейтинг: ', player worldRanking asString; cr.
    ].
]

{ #category : 'review contracts' }
SportClub >> startContractReviewAtSpecificTime: specificTime [
	[
		| now currentTimeString |
		[ true ] whileTrue: [
			now := Time now.
			currentTimeString := now print24.
			(currentTimeString = specificTime) ifTrue: [
				| reviewInfo |
				reviewInfo := self manualReviewContracts.
				Transcript show: reviewInfo; cr.
				(Delay forSeconds: 60) wait.
			].
			(Delay forSeconds: 10) wait.
		].
	] fork.

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
