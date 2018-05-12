/*
	Created By:       Robin
	Date created:     14-Aug-2013
	Purpose:          Rollback changes made to table [tescosubscription].[ConfigurationSettings]
	Usage:            Data used for Delivery Saver
	Data Type:        Hybrid - Updated via DB script or application


	--Modifications History--
	Changed On   Changed By        Defect            Description
    23-Apr-2014  Saritha Kommineni                   Rollback for RenewalInProgressAttempts 
*/ 

SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

CREATE TABLE #InsertData(
	[SettingName] [varchar](255) NOT NULL,
	[SettingValue] [varchar](255) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SettingName] PRIMARY KEY CLUSTERED 
(
	[SettingValue] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE #InsertData ADD  CONSTRAINT [DF_ConfigurationSettings_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]
ALTER TABLE #InsertData ADD  CONSTRAINT [DF_ConfigurationSettings_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

INSERT INTO #INSERTDATA(
	SettingName,
	SettingValue)


SELECT 'RenewalInProgressAttempts',2
UNION ALL
SELECT 'SuspendedToCancelledStatusDuration',42

SELECT @notExists = COUNT(1) 
FROM #INSERTDATA ToInsert
LEFT JOIN [tescosubscription].[ConfigurationSettings] DestTable
ON  ToInsert.SettingValue = DestTable.SettingValue
WHERE DestTable.SettingValue Is Null


DELETE [tescosubscription].[ConfigurationSettings]
FROM #INSERTDATA ToInsert
JOIN [tescosubscription].[ConfigurationSettings] DestTable
ON  ToInsert.SettingValue = DestTable.SettingValue

SET @deleted = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [tescosubscription].[ConfigurationSettings].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) into [tescosubscription].[ConfigurationSettings].'

DROP TABLE #INSERTDATA

GO
