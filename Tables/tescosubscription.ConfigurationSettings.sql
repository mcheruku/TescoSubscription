
/*

	Author:			Robin John
	Date created:	14-08-2013
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
         
*/



IF OBJECT_ID(N'[tescosubscription].[ConfigurationSettings]',N'U') IS NULL
BEGIN

	CREATE TABLE [tescosubscription].[ConfigurationSettings](
	[SettingName] [varchar](255) NOT NULL,
	[SettingValue] [varchar](255) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_PersonalizedSavingsConfig_UTCCreatedDateTime]  DEFAULT (getutcdate()),
	[UTCUpdatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_PersonalizedSavingsConfig_UTCUpdatedDateTime]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_SettingName] PRIMARY KEY CLUSTERED
(
	[SettingName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	

IF OBJECT_ID(N'[tescosubscription].[ConfigurationSettings]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[ConfigurationSettings] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[ConfigurationSettings] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[ConfigurationSettings] already exists.'
	END
GO
