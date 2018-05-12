/*
	Created By:       Rajendra Singh
	Date created:     27-Jul-2011
	Purpose:          Insert records to table [tescosubscription].[ChannelMaster]
	Usage:            Data used for Subscriptions
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @inserted INT, @exists INT

SELECT @inserted = 0, @exists = 0

CREATE TABLE #InsertData(
	[ChannelID] [tinyint] NOT NULL,
	[ChannelName] [varchar](20) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_ChannelMaster] PRIMARY KEY CLUSTERED 
(
	[ChannelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_ChannelMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_ChannelMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	ChannelID,
	ChannelName)	
SELECT 1,'WEB'
UNION ALL
SELECT 2,'Subscriptions'

SELECT @exists = COUNT(1) 
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[ChannelMaster] DestTable
ON  ToInsert.ChannelID = DestTable.ChannelID

INSERT INTO [tescosubscription].[ChannelMaster](
	ChannelID,
	ChannelName,
	UTCCreatedDateTime,
	UTCUpdatedDateTime)
SELECT 
	ToInsert.ChannelID,
	ToInsert.ChannelName,
	ToInsert.UTCCreatedDateTime,
	ToInsert.UTCUpdatedDateTime
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[ChannelMaster] DestTable
ON  ToInsert.ChannelID = DestTable.ChannelID
WHERE DestTable.ChannelID Is Null

SET @inserted = @@ROWCOUNT

PRINT 'EXISTS - ' + CONVERT(varchar(10), @exists) + ' record(s) already existed in [tescosubscription].[ChannelMaster].'
PRINT 'INSERTED - ' + CONVERT(varchar(10), @inserted) + ' record(s) into [tescosubscription].[ChannelMaster].'

DROP TABLE #INSERTDATA

GO
