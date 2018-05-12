USE [TescoSubscription]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : TABLE [Coupon].[CampaignTypeMaster]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK TABLE [Coupon].[CampaignTypeMaster]
** DATE WRITTEN   : 06/05/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CampaignTypeMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [Coupon].[CampaignTypeMaster]

		IF OBJECT_ID(N'[Coupon].[CampaignTypeMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CampaignTypeMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CampaignTypeMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [Coupon].[CampaignTypeMaster] does not exist.'
	END
GO
