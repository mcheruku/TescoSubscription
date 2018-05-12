/*
	Created By:       Saritha Kommineni
	Date created:     27-Jul-2011
	Purpose:          Insert records to table [tescosubscription].[CountryCurrencyMap]
	Usage:            Data used for Grocery Subs
	

	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
	[CountryCurrencyID] [tinyint] NOT NULL,
	[CountryCode] [char](2) NOT NULL,
	[CountryCurrency] [char](3) NOT NULL,
	[CurrencyDesc] [varchar](30) NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_CountryMaster] PRIMARY KEY CLUSTERED 
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

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[CountryCurrencyMap] DestTable
ON  ToInsert.CountryCurrencyID = DestTable.CountryCurrencyID

INSERT INTO [tescosubscription].[CountryCurrencyMap](
	CountryCurrencyID,
	CountryCode,
	CountryCurrency,
	CurrencyDesc,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.CountryCurrencyID,
	ToInsert.CountryCode,
	ToInsert.CountryCurrency,
	ToInsert.CurrencyDesc,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[CountryCurrencyMap] DestTable
ON  ToInsert.CountryCurrencyID = DestTable.CountryCurrencyID
WHERE DestTable.CountryCurrencyID Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[CountryCurrencyMap].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[CountryCurrencyMap].'

DROP TABLE #INSERTDATA

GO
