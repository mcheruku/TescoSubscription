USE [TescoSubscription]
GO
/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE TABLE  
** NAME           : TABLE [Coupon].[CampaignAttributes]  
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE TABLE [Coupon].[CampaignAttributes]
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


IF OBJECT_ID(N'[Coupon].[CampaignAttributes]',N'U') IS NULL
	BEGIN

	CREATE TABLE [Coupon].[CampaignAttributes](
		[CampaignID] [BIGINT] NOT NULL,
		[AttributeID] [SMALLINT] NOT NULL,
		[AttributeValue] [NVARCHAR](50) NOT NULL,
		[UTCCreatedDateTime] [SMALLDATETIME] NOT NULL,
		[UTCUpdatedDateTime] [SMALLDATETIME] NOT NULL,
	 CONSTRAINT [PK_CampaignAttributes] PRIMARY KEY CLUSTERED 
	(
		[CampaignID] ASC,
		[AttributeID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]


	ALTER TABLE [Coupon].[CampaignAttributes] ADD  CONSTRAINT [DF_CampaignAttributes_UTCCreatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCcreatedDateTime]


	ALTER TABLE [Coupon].[CampaignAttributes] ADD  CONSTRAINT [DF_CampaignAttributes_UTCUpdatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCUpdatedDateTime]

	IF OBJECT_ID(N'[Coupon].[CampaignAttributes]',N'U') IS NOT NULL
				BEGIN
					PRINT 'SUCCESS - Table [Coupon].[CampaignAttributes] created.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Table [Coupon].[CampaignAttributes] not created.',16,1)
				END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CampaignAttributes] already exists.'
	END
GO



