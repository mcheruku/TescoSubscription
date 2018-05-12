USE TescoSubscription
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : ROLLBACK SCRIPT  
** NAME           : Rollback Migration Data and data cleaning from [Coupon].[CampaignAttributes], 
**					[Coupon].[CouponCustomerMap],[Coupon].[CouponRedemption],[Coupon].[Coupon],
**					[Coupon].[Campaign]
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL ROLLBACK migration data from above mentioned tables.
** DATE WRITTEN   : 24 July 2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
********************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
SET NOCOUNT ON

DECLARE @CouponCount			BIGINT
		,@CoupRedmpCount		BIGINT
		,@CampAttrCount			BIGINT
		,@CoupCustMCount		BIGINT
		,@CampaignCount			BIGINT
DECLARE @ErrorMessage			NVARCHAR(2048)

BEGIN TRY

BEGIN TRANSACTION [Rollback_CouponData]

IF OBJECT_ID(N'[Coupon].[CampaignAttributes]',N'U') IS NOT NULL
	BEGIN 
		DELETE FROM [Coupon].[CampaignAttributes]
		
		SET @CampAttrCount = @@ROWCOUNT
		
		PRINT 'Records Deleted under rollback from [Coupon].[CampaignAttributes] - ' + CONVERT(varchar(20), @CampAttrCount)
	END

IF OBJECT_ID(N'[Coupon].[CouponCustomerMap]',N'U') IS NOT NULL
	BEGIN 
		DELETE FROM [Coupon].[CouponCustomerMap]
		
		SET @CoupCustMCount = @@ROWCOUNT
		
		PRINT 'Records Deleted ubder rollback from [Coupon].[CouponCustomerMap] - ' + CONVERT(varchar(20), @CoupCustMCount)	
	END
	

	
IF OBJECT_ID(N'[Coupon].[Campaign]',N'U') IS NOT NULL
	BEGIN 
	IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Coupon' AND TABLE_SCHEMA = 'Coupon'  AND  COLUMN_NAME = 'CampaignID')
		BEGIN	
			UPDATE [Coupon].[Coupon]
			SET CampaignID = NULL
		END
				
		DELETE FROM Coupon.Campaign		
		SET @CampaignCount = @@ROWCOUNT
		
		PRINT 'Records Deleted under rollback from [Coupon].[Campaign] - ' + CONVERT(VARCHAR(20), @CampaignCount)

	END

IF EXISTS (SELECT 1 FROM COUPON.COUPON WHERE LEN(COUPONCODE) > 5)
	BEGIN
			
		;WITH DelCoupRed AS
		( SELECT CR.* FROM [Coupon].[CouponRedemption] CR
			WHERE LEN(CR.CouponCode) > 5		
		)
		DELETE FROM DelCoupRed
		SET @CoupRedmpCount = @@ROWCOUNT
		
		SELECT @CouponCount = Count(*) FROM Coupon.Coupon WHERE LEN(CouponCode) > 5

		;WITH DelCoup AS
		( SELECT C.* FROM [Coupon].[Coupon] C
			WHERE LEN(C.CouponCode) > 5		
		)
		DELETE FROM DelCoup	
		
		

		IF(@@ROWCOUNT <> @CouponCount)
			BEGIN
				ROLLBACK TRANSACTION [Rollback_CouponData]
				
				RAISERROR ('Failure - Number of Coupons expected to be deleted don''t match with the ones which got deleted',16,1)
			END
			
		PRINT 'Records Deleted under rollback from [Coupon].[CouponRedemption] - ' + CONVERT(VARCHAR(20), @CoupRedmpCount)
		PRINT 'Records Deleted under rollback from [Coupon].[Coupon] - ' + CONVERT(VARCHAR(20), @CouponCount)

	END
	
COMMIT TRANSACTION [Rollback_CouponData]
	
END TRY

BEGIN CATCH
	SET @ErrorMessage = ERROR_MESSAGE()
	
	IF @@TRANCOUNT > 0
	BEGIN
		ROLLBACK TRANSACTION [Rollback_CouponData]
	END
	
	RAISERROR (
			'Rollback Coupon Data Error = (%s)',
			16,
			1,
			@ErrorMessage
		)

END CATCH
GO