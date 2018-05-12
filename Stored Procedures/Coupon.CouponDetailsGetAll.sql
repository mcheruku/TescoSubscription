IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponDetailsGetAll]
    
    IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsGetAll] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponDetailsGetAll] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponDetailsGetAll]
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Get All Coupons Details


Example:
Execute [coupon].[CouponDetailsGetAll]
--Modifications History--
Changed On   Changed By  Defect  Changes  Change Description 

*/

BEGIN
	SET NOCOUNT ON;	
	
	SELECT c.CouponID,
	       c.CouponCode,
	       c.DescriptionShort,
	       c.DescriptionLong,
	       c.Amount,
	       c.RedeemCount,
	       c.IsActive,
	       c.UTCCreatedeDateTime,
	       (
	           SELECT ca.AttributeID,
	                  ca.AttributeValue 
	           FROM   Coupon.CouponAttributes ca	           
	           WHERE  ca.CouponID = c.CouponID
	                  FOR XML PATH('CouponAttribute'),TYPE, ROOT('CouponAttributes')
	       ) Attributes
	FROM   Coupon.Coupon c (NOLOCK)	
	ORDER BY
	       c.UTCCreatedeDateTime DESC
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponDetailsGetAll] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsGetAll]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsGetAll] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponDetailsGetAll] not created.',
        16,
        1
    )
END
GO
