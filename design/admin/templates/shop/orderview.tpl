<div class="context-block">

<form action={concat("/shop/orderlist")|ezurl} method="post" name="Orderlist">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Order #%order_id'|i18n( 'design/admin/shop/orderview',, hash( '%order_id', $order.order_nr ) )}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Conten START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="context-attributes">

{shop_account_view_gui view=html order=$order}

<b>{'Product items'|i18n( 'design/admin/shop/orderview' )}</b>
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<th>{'Product'|i18n( 'design/admin/shop/orderview' )}</th>
	<th>{'Count'|i18n( 'design/admin/shop/orderview' )}</th>
	<th>{'VAT'|i18n( 'design/admin/shop/orderview' )}</th>
	<th>{'Price ex. VAT'|i18n( 'design/admin/shop/orderview' )}</th>
	<th>{'Price inc. VAT'|i18n( 'design/admin/shop/orderview' )}</th>
	<th>{'Discount'|i18n( 'design/admin/shop/orderview' )}</th>
	<th>{'Total Price ex. VAT'|i18n( 'design/admin/shop/orderview' )}</th>
	<th>{'Total Price inc. VAT'|i18n( 'design/admin/shop/orderview' )}</th>
</tr>
{section name=ProductItem loop=$order.product_items show=$order.product_items sequence=array(bglight,bgdark)}
<tr>
    {section show=and( $ProductItem:item.item_object.contentobject, $ProductItem:item.item_object.contentobject.main_node )}
    {let node_url=$ProductItem:item.item_object.contentobject.main_node.url_alias}
    <td>{$ProductItem:item.item_object.contentobject.class_identifier|class_icon( small,$ProductItem:item.item_object.contentobject.class_name )}&nbsp;{section show=$:node_url}<a href={$:node_url|ezurl}>{/section}{$ProductItem:item.item_object.contentobject.name|wash}{section show=$:node_url}</a>{/section}</td>
    {/let}
    {section-else}
    <td>{false()|class_icon( small )}&nbsp;{$ProductItem:item.item_object.name|wash}</td>
    {/section}
	<td class="number" align="right">{$ProductItem:item.item_count}</td>
	<td class="number" align="right">{$ProductItem:item.vat_value}&nbsp;%</td>
	<td class="number" align="right">{$ProductItem:item.price_ex_vat|l10n(currency)}</td>
	<td class="number" align="right">{$ProductItem:item.price_inc_vat|l10n(currency)}</td>
	<td class="number" align="right">{$ProductItem:item.discount_percent}&nbsp;%</td>
	<td class="number" align="right">{$ProductItem:item.total_price_ex_vat|l10n(currency)}</td>
	<td class="number" align="right">{$ProductItem:item.total_price_inc_vat|l10n(currency)}</td>
</tr>
{section show=$ProductItem:item.item_object.option_list}
<tr>
    <td colspan='3'>
    <table border="0">
    <tr>
        <td colspan='3'>{'Selected options'|i18n( 'design/admin/shop/confirmorder' )}</td>
    </tr>
    {section var=Options loop=$ProductItem:item.item_object.option_list}
    <tr>
        <td>{$:Options.item.name|wash}</td>
        <td>{$:Options.item.value}</td>
        <td class="number" align="right">{$:Options.item.price|l10n( currency )}</td>
    </tr>
    {/section}
    </table>
    </td>
    <td colspan='5'>
  </td>
</tr>
{/section}
{/section}
</table>

<b>{'Order summary'|i18n( 'design/admin/shop/orderview' )}:</b><br />
<table class="list" cellspacing="0">
<tr>
    <td>{'Subtotal of items'|i18n( 'design/admin/shop/orderview' )}:</td>
    <td class="number" align="right">{$order.product_total_ex_vat|l10n(currency)}</td>
    <td class="number" align="right">{$order.product_total_inc_vat|l10n(currency)}</td>
</tr>

{section name=OrderItem loop=$order.order_items show=$order.order_items sequence=array(bglight,bgdark)}
<tr>
	<td>{$OrderItem:item.description}:</td>
	<td class="number" align="right">{$OrderItem:item.price_ex_vat|l10n(currency)}</td>
	<td class="number" align="right">{$OrderItem:item.price_inc_vat|l10n(currency)}</td>
</tr>
{/section}
<tr>
    <td><b>{'Order total'|i18n( 'design/admin/shop/orderview' )}</b></td>
    <td class="number" align="right"><b>{$order.total_ex_vat|l10n(currency)}</b></td>
    <td class="number" align="right"><b>{$order.total_inc_vat|l10n(currency)}</b></td>
</tr>
</table>

</div>

{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
<input type="hidden" name="DeleteIDArray[]" value="{$order.order_nr}" />
<input class="button" type="submit" name="RemoveButton" value="{'Remove'|i18n( 'design/admin/shop/orderview' )}" title="{'Remove this order.'|i18n( 'design/admin/shop/orderview' )}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</form>

</div>
