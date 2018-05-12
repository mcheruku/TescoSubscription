USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignCountGetAll]

		IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignCountGetAll] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignCountGetAll] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignCountGetAll]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignCountGetAll]
** DATE WRITTEN   : 09th July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE Coupon.CampaignCountGetAll
AS

BEGIN

	SELECT COUNT(CampaignID) AS CampaignCount FROM Coupon.Campaign

END

GO
--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignCountGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignCountGetAll]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignCountGetAll] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignCountGetAll] not created.',16,1)
	END
GO