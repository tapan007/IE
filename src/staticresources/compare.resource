(function($){
	var CodeComparator = function(element, options)
	{
		var elem = $(element);
		var obj = this;
		var settings = $.extend({
			baseName: 'Base Text',
			nextName: 'New Text'
		}, options || {});
		// Public method - can be called from client code
		this.publicMethod = function()
		{
			console.log('public method called!');
		};
		// Private method - can only be called from within this object
		this.pmethods = {
	        init: function (){
	        	console.log('init called!'+options);
	        },
	        diffUsingJS: function (viewType,base,newTxt,diffoutputdiv) {
	        	// create a SequenceMatcher instance that diffs the two sets of lines
	            var sm = new difflib.SequenceMatcher(base, newtxt);
	            // get the opcodes from the SequenceMatcher instance
	            // opcodes is a list of 3-tuples describing what changes should be made to the base text
	            // in order to yield the new text
	            var opcodes = sm.get_opcodes();
	            //var diffoutputdiv = $("#diffoutput");
	            //clear every time
	            diffoutputdiv.html('');
	            //while (diffoutputdiv.firstChild) diffoutputdiv.removeChild(diffoutputdiv.firstChild);
	            //var contextSize = $("#contextSize").value;
	           // contextSize = contextSize ? contextSize : null;

	            // build the diff view and add it to the current DOM
	            diffoutputdiv.append(diffview.buildView({
	                baseTextLines: base,
	                newTextLines: newtxt,
	                opcodes: opcodes,
	                // set the display titles for each resource
	                baseTextName: settings.baseName,
	                newTextName: nextName.nextName,
	                contextSize: null,
	                viewType:  viewType
	            }));
	        }
	    };
	};
	$.fn.CodeComparator = function(options)
	{
		return this.each(function()
		{
			var element = $(this);
			// Return early if this element already has a plugin instance
			if (element.data('codecomparator')) return;
			// pass options to plugin constructor
			var codecomparator = new CodeComparator(this, options);
			codecomparator.pmethods.init();
			// Store plugin object in this element's data
			element.data('codecomparator', codecomparator);
				
		});
	};
})(jQuery);