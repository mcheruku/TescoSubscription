USE TescoSubscription
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : Procedure [Coupon].[CampaignEdit]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK PROCEDURE [Coupon].[CampaignEdit]
** DATE WRITTEN   : 09th July 2013                    
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignEdit] 

		IF OBJECT_ID(N'[Coupon].[CampaignEdit]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignEdit]  dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignEdit]  not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [Coupon].[CampaignEdit]  does not exist.'
	END
GO