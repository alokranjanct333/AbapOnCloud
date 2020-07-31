@AbapCatalog.sqlViewName: 'ZIVENDORSUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Vendor Sustain'
define view Z_I_Vendor_Sustain as select from zsustain join zelbp on zsustain.ekorg = zelbp.ekorg
                                                               and zsustain.lifnr = zelbp.lifnr 
 {

  /** DIMENSIONS **/
  @UI.lineItem: [ { position: 10,label: 'Purchasing Org' }]
key zelbp.ekorg,
@UI.lineItem: [ { position: 20,label: 'Vendor' }]
key zelbp.lifnr,

  /** MEASURES **/
@UI.lineItem: [ { position: 30,label: 'Score' }]  
@Aggregation.default: #SUM  
zelbp.beurt,
@UI.lineItem: [ { position: 40,label: 'Price' }]
@Aggregation.default: #SUM
zelbp.krt01 as Price,
@UI.lineItem: [ { position: 50,label: 'Quality' }]
@Aggregation.default: #SUM
zelbp.krt02 as Quality,
@UI.lineItem: [ { position: 60,label: 'Delivery' }]
@Aggregation.default: #SUM
zelbp.krt03 as Delivery,
@UI.lineItem: [ { position: 70,label: 'Service' }]
@Aggregation.default: #SUM
zelbp.krt04 as Service,
@UI.lineItem: [ { position: 80,label: 'Sustainability' }]
@Aggregation.default: #SUM
zelbp.krt05 as Sustainability,
@UI.lineItem: [ { position: 90,label: 'Socialresponsibility' }]
@Aggregation.default: #SUM
zsustain.krt01 as Socialresponsibility ,
@Aggregation.default: #SUM
@UI.lineItem: [ { position: 90,label: 'Environment' }]
zsustain.krt02 as Environment ,
@Aggregation.default: #SUM
@UI.lineItem: [ { position: 90,label: 'Total Eco Score' }]
zsustain.krt03 as TotalEcoScore    
    
}
