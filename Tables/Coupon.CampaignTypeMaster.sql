USE [TescoSubscription]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE TABLE  
** NAME           : TABLE [Coupon].[CampaignTypeMaster]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE TABLE [Coupon].[CampaignTypeMaster] 
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

SET ANSI_PADDING ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignTypeMaster]',N'U') IS NULL
	BEGIN


	CREATE TABLE [Coupon].[CampaignTypeMaster](
		[CampaignTypeID] [INT] IDENTITY(1,1) NOT NULL,
		[CampaignTypeName] [NVARCHAR](50) NOT NULL,
		[Description] [NVARCHAR](200) NULL,
		[IsActive] [BIT] NOT NULL,
		[UTCCreatedDateTime] [SMALLDATETIME] NOT NULL,
		[UTCUpdatedDateTime] [SMALLDATETIME] NOT NULL,
	 CONSTRAINT [PK_CampaignTypeMaster] PRIMARY KEY CLUSTERED 
	(
		[CampaignTypeID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]


	ALTER TABLE [Coupon].[CampaignTypeMaster] ADD  CONSTRAINT [DF_CampaignTypeMaster_IsActive]  DEFAULT ((0)) FOR [IsActive]


	ALTER TABLE [Coupon].[CampaignTypeMaster] ADD  CONSTRAINT [DF_CampaignTypeMaster_UTCCreatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCCreatedDateTime]


	ALTER TABLE [Coupon].[CampaignTypeMaster] ADD  CONSTRAINT [DF_CampaignTypeMaster_UTCUpdatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCUpdatedDateTime]

	IF OBJECT_ID(N'[Coupon].[CampaignTypeMaster]',N'U') IS NOT NULL
				BEGIN
					PRINT 'SUCCESS - Table [Coupon].[CampaignTypeMaster] created.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Table [Coupon].[CampaignTypeMaster] not created.',16,1)
				END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CampaignTypeMaster] already exists.'
	END
GO




