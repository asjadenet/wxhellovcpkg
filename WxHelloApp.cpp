#include <wx/wx.h>
#include "wxHelloProjectFrameMain.h"
#include "wxHelloProjectPanelMain.h"


class wxHelloApp: public wxApp {

public:
	wxHelloApp() = default;
	virtual ~wxHelloApp() = default;
	bool OnInit() override;
	int OnExit() override { return 0; }

};

IMPLEMENT_APP (wxHelloApp);

inline bool wxHelloApp::OnInit() {
	auto *mainFrame = new wxHelloProjectFrameMain(nullptr);
	new wxHelloProjectPanelMain(mainFrame);
	mainFrame->Show(true);
	SetTopWindow(mainFrame);
	return true;
}