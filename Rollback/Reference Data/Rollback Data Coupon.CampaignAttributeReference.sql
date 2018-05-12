USE [TescoSubscription]
GO

/*
 Type           : Rollback Refrence Data  
 Name           : TABLE [Coupon].[CampaignAttributeReference]   
 Author         : Robin
 Description    : THIS SCRIPT WILL INSERT MASTER DATA IN [Coupon].[CampaignAttributeReference] DATE WRITTEN   : 06/03/2013                     
 */
SET NOCOUNT ON

DECLARE @deleted INT, @notExists INT

SELECT @deleted = 0, @notExists = 0

SELECT @notExists = COUNT(1) 
FROM  (
SELECT 7 AS [AttributeID],'IsClubCardBoost' AS [Description]
UNION ALL
SELECT 8 AS [AttributeID],'ClubCardVoucherValue' AS [Description]) ToInsert
JOIN [Coupon].[CampaignAttributeReference] DestTable
ON  ToInsert.[AttributeID] = DestTable.[AttributeID]
WHERE DestTable.[AttributeID] Is Null

DELETE [Coupon].[CampaignAttributeReference] 
FROM  (
SELECT 7 AS [AttributeID],'IsClubCardBoost' AS [Description]
UNION ALL
SELECT 8 AS [AttributeID],'ClubCardVoucherValue' AS [Description]) ToInsert
JOIN [Coupon].[CampaignAttributeReference] DestTable
ON  ToInsert.[AttributeID] = DestTable.[AttributeID]

SET @deleted  = @@ROWCOUNT

PRINT 'NOT EXISTS - ' + CONVERT(varchar(10), @notExists) + ' record(s) already existed in [Coupon].[CampaignAttributeReference].'
PRINT 'DELETED - ' + CONVERT(varchar(10), @deleted) + ' record(s) from [Coupon].[CampaignAttributeReference].'



GO