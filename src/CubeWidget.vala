using Gtk;
using Cairo;

namespace CubeGame {
	
	public class CubeWidget : DrawingArea {
		
		private GameArea myparent;
		public int Color;
		
		public int Number;
		
		public bool Mark;
		
		public bool Debug;
		
		public signal void selected_event (int myNumber, int myColor);
	
	    public CubeWidget (int mynum, GameArea ga, int size, int maxcolor) {
		    Number = mynum;
	        add_events (Gdk.EventMask.BUTTON_PRESS_MASK
	                  | Gdk.EventMask.BUTTON_RELEASE_MASK
	                  | Gdk.EventMask.POINTER_MOTION_MASK);
	        set_size_request (size, size);
	        var rand = new Rand ();
	        Color = rand.int_range (0, maxcolor);
	        if(Color==3)Color = rand.int_range (2, maxcolor);
	        Mark = false;
	        Debug = false;
	        myparent = ga;
	        myparent.check_mark_event.connect(marked_destroy_event);
	    }
	
	    public override bool expose_event (Gdk.EventExpose event) {
	
	        var cr = Gdk.cairo_create (this.window);
	        if (Mark){
		        var x = 0 + this.allocation.width / 2;
		        var y = 0 + this.allocation.height / 2;    
		        var radius = double.min (this.allocation.width / 2, this.allocation.height / 2) - 5;
				cr.arc (x, y, radius, 0, 2 * Math.PI);
			}
			else
			{
	        	cr.rectangle(0,0,this.allocation.width, this.allocation.height);
	        	cr.set_source_rgb (1, 1, 1); //color == 3 or higher
        	}
	        if(Color==0) cr.set_source_rgb (1, 0, 0);
	        if(Color==1) cr.set_source_rgb (0, 1, 0);
	        if(Color==2) cr.set_source_rgb (0, 0, 1);
	        if(Color==3) cr.set_source_rgb (1, 1, 0);
	        if(Color==4) cr.set_source_rgb (0, 1, 1);
	        if(Color==5) cr.set_source_rgb (0.1, 0.1, 0.1);
	        if(Color==6) cr.set_source_rgb (0.2, 0.2, 0.2);
	        if(Color==7) cr.set_source_rgb (0.3, 0.3, 0.3);
	        if(Color==8) cr.set_source_rgb (0.4, 0.4, 0.4);
	        if(Color==9) cr.set_source_rgb (0.5, 0.5, 0.5);
	        if(Color==10) cr.set_source_rgb (0.6, 0.6, 0.6);
	        if(Color==11) cr.set_source_rgb (0.7, 0.7, 0.7);
	            
	        cr.fill_preserve ();
	        cr.set_source_rgb (0, 0, 0);
	        cr.stroke ();
	        cr.rectangle (event.area.x, event.area.y, event.area.width, event.area.height);
	        cr.clip ();
	        
	        return false;
	    }
	
	    public override bool button_press_event (Gdk.EventButton event) {
	        Mark = true;
	        selected_event (Number, Color); 
	        print (" ");
	        return false;
	    }
	    
	    public void marked_destroy_event () {
    		if(Mark==true) {
    			//Color=4;
    			this.queue_draw();
    			//print ("remove: %d\n",Number);
    			if(Debug==false)this.destroy();
    		}
		}
	
	    public override bool button_release_event (Gdk.EventButton event) {
	        print ("\n");
	        return false;
	    }
	
	    public override bool motion_notify_event (Gdk.EventMotion event) {
	        //print ("mne ");
	        return false;
	    }
	}    
}
