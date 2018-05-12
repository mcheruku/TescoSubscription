IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [coupon].[CouponDetailsXMLGet]
    
    IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NULL
    BEGIN
        PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsXMLGet] dropped.'
    END
    ELSE
    BEGIN
        RAISERROR(
            'FAIL - Procedure [coupon].[CouponDetailsXMLGet] not dropped.',
            16,
            1
        )
    END
END
GO

CREATE PROCEDURE [coupon].[CouponDetailsXMLGet]
(
	@couponId BIGINT
)
AS
	/*
Author:		Swaraj
Created:	04/Oct/2012
Purpose:	Get Coupons Details of Single Coupon


Example:
Execute [coupon].[CouponDetailsXMLGet] 70
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
	FROM   Coupon.Coupon c 
	WHERE c.CouponId = @couponId
	ORDER BY
	       c.UTCCreatedeDateTime DESC
END
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [coupon].[CouponDetailsXMLGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[coupon].[CouponDetailsXMLGet]', N'P') IS NOT NULL
BEGIN
    PRINT 'SUCCESS - Procedure [coupon].[CouponDetailsXMLGet] created.'
END
ELSE
BEGIN
    RAISERROR(
        'FAIL - Procedure [coupon].[CouponDetailsXMLGet] not created.',
        16,
        1
    )
END
GO
