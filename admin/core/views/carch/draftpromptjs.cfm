<cfoutput>
<script type="text/javascript">
$(function(){
	initDraftPrompt();	
});

function initDraftPrompt(){
	$('a.draftprompt').click(function(e){
		e.preventDefault(); // stop the link's normal clicking behavior
		var node = jQuery(this).parents(".mura-node-data:first");		
		var a = jQuery(this);

		//alert(node.attr('data-contentid'))
		
		$.ajax({
			  url: "./index.cfm?muraAction=carch.draftpromptdata&contentid=" + node.attr('data-contentid') + "&siteid=" + node.attr('data-siteid'),
			  context: this,
			  success: function(resp){
				  if (resp.showdialog !== undefined && resp.showdialog === "true"){
					jQuery(resp.message).dialog({
						title:"#JSStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.draftprompt.title'))#",
						modal:true,
						width:"400px",
						buttons: {
							"#JSStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.draftprompt.cancel'))#":function(){
								jQuery(this).dialog('close');
							}
							/*
							,
							"#JSStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.draftprompt.latest'))#": function(){
								var href = a.attr('href').replace(node.attr('data-contenthistid'),resp.historyid);
								window.location = href;
							},
							"#JSStringFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.draftprompt.published'))#" : function(){
								window.location = a.attr('href');
							}
							*/
						}
					});
					$(".draft-prompt-option").click(function(e){
						e.preventDefault();
						var href = a.attr('href').replace(node.attr('data-contenthistid'),$(this).attr('data-contenthistid'));
						window.location = href;
					});
				} else {
					window.location = a.attr('href');
				}
			}
		});
		
	});
	
}
</script>
</cfoutput>