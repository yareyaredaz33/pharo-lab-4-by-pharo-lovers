Class {
	#name : 'SportspersonTest',
	#superclass : 'TestCase',
	#category : 'Sports-Tests',
	#package : 'Sports',
	#tag : 'Tests'
}

{ #category : 'tests' }
SportspersonTest >> testEarningsComparison [
    | tennisPlayer footballPlayer |
    tennisPlayer := TennisPlayer new initializeWithLastName: 'Federer' age: 40 nationality: 'Switzerland' worldRanking: 5 earnings: #(10000 20000 15000).
    footballPlayer := FootballPlayer new initializeWithLastName: 'Messi' age: 35 nationality: 'Argentina' club: 'PSG' contract: 1000000 goals: 30.

    self assert: (tennisPlayer earningsLessThan: footballPlayer) = true.
]

{ #category : 'tests' }
SportspersonTest >> testFootballPlayerEarnings [
    | player |
    player := FootballPlayer new initializeWithLastName: 'Messi' age: 35 nationality: 'Argentina' club: 'PSG' contract: 1000000 goals: 30.
    self assert: player totalEarnings = 1300000.  "1% за кожен гол"
]

{ #category : 'tests' }
SportspersonTest >> testTennisPlayerEarnings [
    | player |
    player := TennisPlayer new initializeWithLastName: 'Federer' age: 40 nationality: 'Switzerland' worldRanking: 5 earnings: #(10000 20000 15000).
    self assert: player totalEarnings = 45000.
]
