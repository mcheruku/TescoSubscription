USE TescoSubscription
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : Procedure [Coupon].[CampaignCodeGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [Coupon].[CampaignCodeGetAll]
** DATE WRITTEN   : 01/07/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCodeGetAll] 

		IF OBJECT_ID(N'[Coupon].[CampaignCodeGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCodeGetAll]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCodeGetAll]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CampaignCodeGetAll]  does not exist.'
	END
GO