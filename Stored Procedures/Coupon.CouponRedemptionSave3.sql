USE [TescoSubscription]
GO
IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Coupon].[CouponRedemptionSave3]
    
    IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave3] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [Coupon].[CouponRedemptionSave3] not dropped.',
            16,
            1
        )
    END
END

GO

CREATE PROCEDURE [Coupon].[CouponRedemptionSave3]
(
	@CouponCode NVARCHAR(MAX)
   ,@CustomerID BIGINT	
)
AS
/*
	Author:		Robin
	Created:	21 Jan 2014 
	Purpose:	To increase the coupon redemption count and map customerid to couponid

	--Modifications History--
 	Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	


	SET NOCOUNT ON;	

DECLARE
 @errorDescription	NVARCHAR(2048)
,@error				INT
,@errorProcedure	SYSNAME
,@errorLine			INT
,@Delimiter    NVARCHAR(1)
,@String       NVARCHAR(25)
 
SET @Delimiter = ','

DECLARE @CouponTable  TABLE (String NVARCHAR(44))
 

INSERT INTO @CouponTable ( [String] )
(SELECT Item FROM [dbo].[ConvertListToTable] (@CouponCode,@Delimiter))

--    END

	  
    BEGIN TRY
 
		BEGIN TRANSACTION
	--SELECT 1/0
		INSERT INTO [Coupon].[CouponRedemption]
			 ([CouponCode]
			 ,[CustomerID])
				(SELECT UPPER(String),@CustomerID FROM @CouponTable)

	     
				
		UPDATE [Coupon].[Coupon]
		SET RedeemCount = RedeemCount + 1
			,UTCUpdatedDateTime = GETUTCDATE()
		WHERE 
			CouponCode IN (SELECT String FROM @CouponTable)

		 
			
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
GRANT EXECUTE ON [Coupon].[CouponRedemptionSave3] TO [SubsUser]
GO

IF OBJECT_ID(N'[Coupon].[CouponRedemptionSave3]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [Coupon].[CouponRedemptionSave3] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [Coupon].[CouponRedemptionSave3] not created.',
        16,
        1
    )
END
GO

