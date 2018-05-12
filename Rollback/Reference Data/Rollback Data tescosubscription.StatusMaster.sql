/*
	Created By:       Rajendra Singh
	Date created:     27-Jul-2011
	Purpose:          Rollback changes made to table [tescosubscription].[StatusMaster]
	Usage:            Data used for Click And Collect 
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On  Changed By        Defect            Description
*/ 

SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

CREATE TABLE #InsertData(
	[StatusId] [tinyint] NOT NULL,
	[StatusCode] [tinyint] NOT NULL,
	[StatusName] [varchar](20) NOT NULL,
	[StatusType] [varchar](50) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_StatusMaster] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_StatusMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_StatusMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	StatusId,
	StatusCode,
	StatusName,
	StatusType)


SELECT 15,5,'Order Initiated','CustomerSubs'

SELECT @notExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[StatusMaster] DestTable
ON  ToInsert.StatusId = DestTable.StatusId
WHERE DestTable.StatusId Is Null


DELETE [tescosubscription].[StatusMaster]
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[StatusMaster] DestTable
ON  ToInsert.StatusId = DestTable.StatusId

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [tescosubscription].[StatusMaster].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [tescosubscription].[StatusMaster].'

DROP TABLE #INSERTDATA

GO
