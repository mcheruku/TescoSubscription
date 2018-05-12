IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [Coupon].[CouponRedemptionSave]

		IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [Coupon].[CouponRedemptionSave] not dropped.',16,1)
			END
	END
GO





CREATE PROCEDURE [Coupon].[CouponRedemptionSave]
(
	@CouponCode NVARCHAR(25)
	,@CustomerID BIGINT	
)
AS

/*
	Author:		Manjunathan
	Created:	18/Sep/2012
	Purpose:	Create Coupon Redemption

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

	*/

BEGIN
	SET NOCOUNT ON;	

	DECLARE	 @errorDescription	NVARCHAR(2048)
		,@error				INT
		,@errorProcedure	SYSNAME
		,@errorLine			INT
	  
	BEGIN TRY
 
	BEGIN TRANSACTION
		
	INSERT INTO [TescoSubscription].[Coupon].[CouponRedemption]
           ([CouponCode]
           ,[CustomerID]           )
     VALUES
           (@CouponCode
			,@CustomerID)
			
	UPDATE Coupon.Coupon
	SET RedeemCount = RedeemCount + 1
		,UTCUpdatedDateTime = GETUTCDATE()
	WHERE 
		CouponCode = @CouponCode
		
	COMMIT TRANSACTION 
	
	END TRY
	BEGIN CATCH

	  SELECT      @errorProcedure         = Routine_Schema  + '.' + Routine_Name
				  , @error                = ERROR_NUMBER()
				  , @errorDescription     = ERROR_MESSAGE()
				  , @errorLine            = ERROR_LINE()
	  FROM  INFORMATION_SCHEMA.ROUTINES
	  WHERE Routine_Type = 'PROCEDURE' and Routine_Name = OBJECT_NAME(@@PROCID)

	 ROLLBACK TRANSACTION 
	 
	 RAISERROR('[Procedure:%s Line:%i Error:%i] %s',16,1,@errorProcedure,@errorLine,@error,@errorDescription)
 
	END CATCH


END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [Coupon].[CouponRedemptionSave] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [Coupon].[CouponRedemptionSave] not created.',16,1)
	END
GO
