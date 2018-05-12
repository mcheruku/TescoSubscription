USE TescoSubscription
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : Procedure [Coupon].[CampaignDetailsGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [Coupon].[CampaignDetailsGetAll]
** DATE WRITTEN   : 06/05/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignDetailsGetAll] 

		IF OBJECT_ID(N'[Coupon].[CampaignDetailsGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignDetailsGetAll]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignDetailsGetAll]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CampaignDetailsGetAll]  does not exist.'
	END
GO