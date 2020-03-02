
// protocol for handling creation of new orbits 
protocol NewOrbitFlow: Coordinator {
    func newOrbit(_ completion: @escaping (String, String) -> ())
}
