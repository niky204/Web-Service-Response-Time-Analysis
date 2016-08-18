import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import eu.impact_project.iif.ws.generic.SoapInput;
import eu.impact_project.iif.ws.generic.SoapOperation;
import eu.impact_project.iif.ws.generic.SoapOutput;
import eu.impact_project.iif.ws.generic.SoapService;

public class ControlPanel {

	public static void main(String[] args) {  
		// TODO Auto-generated method stub
		SoapService service = null;
		try {
			service = new SoapService("http://wsf.cdyne.com/WeatherWS/Weather.asmx?WSDL");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<SoapOperation> allOps = service.getOperations(); 	
		for(int i=0; i<allOps.size();i++){
			System.out.println(allOps.get(i).getName());
		}		
		SoapOperation op = service.getOperation("GetCityWeatherByZIP");
		List<SoapInput> allInputs = op.getInputs();  
		for(int i=0; i<allInputs.size();i++){
			System.out.println("input"+i+" "+allInputs.get(i).getName());
			System.out.println("Multivalued :"+ allInputs.get(i).isMultiValued());
			List<String> possible = allInputs.get(i).getPossibleValues();
			System.out.println(possible.size());
			allInputs.get(i).setValue("91776"); 
		}
		List<SoapOutput> outs=null;
		try {
			outs = op.execute("", "");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for (SoapOutput out : outs) {  
            System.out.println(out.getName());
            System.out.println(out.getValue());
		}
		
	}
}
