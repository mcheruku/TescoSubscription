IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponStop]
    
    IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponStop] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponStop] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponStop]
(
    @CouponId Bigint
)
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Stop a Coupons

execute coupon.couponstop 1
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;
	
	UPDATE Coupon.Coupon
		SET	
			IsActive = 0,
			UTCUpdatedDateTime = GETUTCDATE()	
		WHERE 
			CouponID = @CouponId
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponStop] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponStop]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponStop] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponStop] not created.',
        16,
        1
    )
END
GO
