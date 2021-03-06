USE [TescoSubscription]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CampaignStop]

		IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CampaignStop] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CampaignStop] not dropped.',16,1)
			END
	END
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE PROCEDURE  
** NAME           : PROCEDURE [Coupon].[CampaignStop]   
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE PROCEDURE [Coupon].[CampaignStop]
** DATE WRITTEN   : 27/06/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): 0 in case of success.
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/

CREATE PROCEDURE [Coupon].[CampaignStop] 
(
@CampaignID	BIGINT
)
AS

BEGIN

SET NOCOUNT ON;
DECLARE @ErrorMessage		NVARCHAR(2048)

BEGIN TRY

	BEGIN TRANSACTION [Stop_CampaignCoupon]
	
	UPDATE Coupon.Coupon
	SET	
		IsActive = 0,
		UTCUpdatedDateTime = GETUTCDATE()	
		WHERE 
			CouponID IN (SELECT CouponID 
							FROM Coupon.Coupon C
							WHERE CampaignID = @CampaignID)
	IF (@@ROWCOUNT <> 0)
	BEGIN
		UPDATE Coupon.Campaign
		SET	
			IsActive = 0,
			UTCUpdatedDateTime = GETUTCDATE()	
			WHERE 
				CampaignID = @CampaignID
	END
	ELSE
	BEGIN
		SET @ErrorMessage = 'Coupon to be stopped not found for supplied CampaignID'
		
		RAISERROR (
					'%s',
					16,
					1,
					@ErrorMessage
					)
	END
	
	COMMIT TRANSACTION 	[Stop_CampaignCoupon]
	PRINT 'CAMPAIGN AND COUPON(S) STOPPED'		
		
END TRY	
BEGIN CATCH
		SET @ErrorMessage = ERROR_MESSAGE()

		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION [Stop_CampaignCoupon]
		END
		
		RAISERROR (
				'SP - [coupon].[CampaignStop] Error = (%s)',
				16,
				1,
				@ErrorMessage
				)
END CATCH

END
GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CampaignStop] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CampaignStop]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CampaignStop] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CampaignStop] not created.',16,1)
	END
GO