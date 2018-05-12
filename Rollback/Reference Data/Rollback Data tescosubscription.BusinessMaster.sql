/*
	Created By:      Saritha Kommineni
	Date created:     27-Jul-2011
	Purpose:          Rollback changes made to table [tescosubscription].[BusinessMaster]
	Usage:            Data used for Grocery Subs


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

CREATE TABLE #InsertData(
	[BusinessID] [tinyint] NOT NULL,
	[BusinessName] [varchar](30) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_tescosubscription.BusinessMaster] PRIMARY KEY CLUSTERED 
(
	[BusinessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_BusinessMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_BusinessMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	BusinessID,
	BusinessName)
	
SELECT 1,'Grocery'


SELECT @notExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[BusinessMaster] DestTable
ON  ToInsert.BusinessID = DestTable.BusinessID
WHERE DestTable.BusinessID Is Null


DELETE [tescosubscription].[BusinessMaster]
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[BusinessMaster] DestTable
ON  ToInsert.BusinessID = DestTable.BusinessID

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [tescosubscription].[BusinessMaster].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [tescosubscription].[BusinessMaster].'

DROP TABLE #INSERTDATA

GO
