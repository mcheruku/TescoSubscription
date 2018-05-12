/*
	Created By:       Rajendra Singh
	Date created:     27-Jul-2011
	Purpose:          Rollback changes made to table [tescosubscription].[ChannelMaster]
	Usage:            Data used for Click And Collect 
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

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

SELECT @notExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[ChannelMaster] DestTable
ON  ToInsert.ChannelID = DestTable.ChannelID
WHERE DestTable.ChannelID Is Null


DELETE [tescosubscription].[ChannelMaster]
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[ChannelMaster] DestTable
ON  ToInsert.ChannelID = DestTable.ChannelID

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [tescosubscription].[ChannelMaster].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [tescosubscription].[ChannelMaster].'

DROP TABLE #INSERTDATA

GO
