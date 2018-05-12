/*
	Created By:       Saritha Kommineni
	Date created:     27-Jul-2011
	Purpose:          Rollback changes made to table [tescosubscription].[CountryCurrencyMap]
	Usage:            Data used for Grocery Subs
	
	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

CREATE TABLE #InsertData(
	[CountryCurrencyID] [tinyint] NOT NULL,
	[CountryCode] [char](2) NOT NULL,
	[CountryCurrency] [char](3) NOT NULL,
	[CurrencyDesc] [varchar](30) NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_tescosubcription_CountryMaster] PRIMARY KEY CLUSTERED 
(
	[CountryCurrencyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_CountryMaster] UNIQUE NONCLUSTERED 
(
	[CountryCode] ASC,
	[CountryCurrency] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_CountryCurrencyMap_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_CountryCurrencyMap_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	CountryCurrencyID,
	CountryCode,
	CountryCurrency,
	CurrencyDesc)
	
SELECT 1,'GB','GBP','UK Pound'

SELECT @notExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[CountryCurrencyMap] DestTable
ON  ToInsert.CountryCurrencyID = DestTable.CountryCurrencyID
WHERE DestTable.CountryCurrencyID Is Null


DELETE [tescosubscription].[CountryCurrencyMap]
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[CountryCurrencyMap] DestTable
ON  ToInsert.CountryCurrencyID = DestTable.CountryCurrencyID

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [tescosubscription].[CountryCurrencyMap].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [tescosubscription].[CountryCurrencyMap].'

DROP TABLE #INSERTDATA

GO
