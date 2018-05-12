USE [TescoSubscription]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE TABLE  
** NAME           : TABLE [Coupon].[CampaignAttributeReference]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE TABLE [Coupon].[CampaignAttributeReference]
** DATE WRITTEN   : 06/03/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignAttributeReference]',N'U') IS NULL
	BEGIN

	CREATE TABLE [Coupon].[CampaignAttributeReference](
		[AttributeID] [SMALLINT] NOT NULL,
		[Description] [NVARCHAR](250) NULL,
		[UTCCreatedDateTime] [SMALLDATETIME] NOT NULL,
		[UTCUpdateDDateTime] [SMALLDATETIME] NOT NULL,
	 CONSTRAINT [PK_CampaignAttributeReference] PRIMARY KEY CLUSTERED 
	(
		[AttributeID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]


	ALTER TABLE [Coupon].[CampaignAttributeReference] ADD  CONSTRAINT [DF_CampaignAttributeReference_UTCCreatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCCreatedDateTime]


	ALTER TABLE [Coupon].[CampaignAttributeReference] ADD  CONSTRAINT [DF_CampaignAttributeReference_UTCUpdatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCupdatedDateTime]

	IF OBJECT_ID(N'[Coupon].[CampaignAttributeReference]',N'U') IS NOT NULL
				BEGIN
					PRINT 'SUCCESS - Table [Coupon].[CampaignAttributeReference] created.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Table[Coupon].[CampaignAttributeReference] not created.',16,1)
				END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CampaignAttributeReference] already exists.'
	END
GO



