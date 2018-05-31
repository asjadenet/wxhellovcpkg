#include <wx/msgdlg.h>
#include "wxHelloProjectPanelMain.h"

wxHelloProjectPanelMain::wxHelloProjectPanelMain( wxWindow* parent )
:
PanelMain( parent )
{

}

void wxHelloProjectPanelMain::on_hello_button_clicked( wxCommandEvent& event )
{
	wxMessageBox( "Hello, " + m_textCtrlName->GetValue() );
}
