// Singleton class for setting service/class done
global class TriggerHelper {
	private static Boolean serviceDone = false;

	public static Boolean getServiceDone() {
		return serviceDone;
	}

	public static void setServiceDone() {
		serviceDone = true;
	}

	/**
	 * Access it outside of this class to stop recursion:
	 * ~ do some code in the service class then ~ TriggerHelper.setServiceDone(); sets to true
	 *
	 * Usually call this within the TriggerHandler.cls:
	 * if (!TriggerHelper.getServiceDone) { run Trigger code }
	 * only run this code when service hasn't run once/prevent recursion
	 */
}
