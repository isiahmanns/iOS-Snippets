//
//  ViewController.swift
//

import UIKit

class ViewController: UIViewController {

    private var imgView = UIImageView()
    private let imgURLStrings: [String: String] = [
        "pizza": "https://foodish-api.herokuapp.com/images/pizza/pizza56.jpg",
        "burger": "https://foodish-api.herokuapp.com/images/burger/burger56.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureImgView()
        fetchAndSetImgView1()
        // fetchAndSetImgView2()
    }

    private func configureImgView() {
        view.addSubview(imgView)

        // Using autolayout for positioning.
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imgView.widthAnchor.constraint(equalToConstant: 200),
            imgView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func fetchAndSetImgView1() {
        // Download image binary and create image from the binary.

        guard let itemURLString = imgURLStrings["pizza"] else { return }
        let url = URL(string: itemURLString)!

        // Det default image first.
        imgView.image = UIImage(named: "placeholder-image")

        // Fetch and set image on background queue.
        DispatchQueue.global(qos: .background).async {
            do {
                // This call fetches image from network url.
                let data = try Data(contentsOf: url)

                // Update UI on main queue (uses another thread to execute my block while other queued tasks on main queue get invoked).
                // Keeps UI going as smooth as possible with no freezing.
                DispatchQueue.main.async {
                    let img = UIImage(data: data)
                    self.imgView.image = img
                }
            } catch {
                print("Problem fetching data from URL: \(error)")
            }
        }
    }

    private func fetchAndSetImgView2() {
        guard let itemURLString = imgURLStrings["burger"] else { return }

        // Fetch and set image on background thread.
        DispatchQueue.global(qos: .background).async {
            // pass link into uiimage and let it handle the downloading
            guard let img = UIImage(contentsOfFile: itemURLString) else {
                print("UIImage(contentsOfFile:) only works for *local* files.")
                return
            }

            // Update UI on main thread.
            DispatchQueue.main.async {
                self.imgView.image = img
            }
        }
    }
}
